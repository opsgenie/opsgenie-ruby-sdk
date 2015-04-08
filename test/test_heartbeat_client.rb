require_relative '../client/opsgenie_client'
require_relative '../request/opsgenie_request'
require 'test/unit'
require 'yaml'

class TestHeartbeatClient < Test::Unit::TestCase

	def setup
		@cli = Client::OpsGenieClient.new 
		conf = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))
		api_key = conf[conf['env']]['hbapiKey']
		@cli.apiKey = api_key
		@sampleUser = conf[conf['env']]['user']
	end

	def test_01_add_heartbeat
		req = Request::AddHeartbeatRequest.new
		# build the request
		req.name = "Heartbeat - 01"
		req.description = "Heartbeat created by one Ruby SDK unit test"
		req.interval = 5.minutes
		req.enabled = true
		# send the request
		resp = @cli.heartbeat().add(req)
		assert_not_nil(resp, "no response returned as adding the heartbeat")
		assert_not_nil(resp.id, "response does not include the id of heartbeat")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server message is not successful: #{resp.status}")

		File.open("hbid.tmp", 'w')  { |file| file.puts resp.id }
	end

	def test_02_update_heartbeat
		req = Request::UpdateHeartbeatRequest.new
		# build the request
		req.id = File.read("hbid.tmp").strip
		req.description = "Heartbeat description is now updated"
		req.interval = 5.days
		# update the heartbeat
		resp = @cli.heartbeat().update(req)
		assert_not_nil(resp, "no response returned as updating the heartbeat")
		assert_not_nil(resp.id, "response does not include the id of heartbeat")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server message is not successful: #{resp.status}")
	end

	def test_03_send_heartbeat
		req = Request::SendHeartbeatRequest.new
		# build the request
		req.name = "Heartbeat - 01"
		# send hb request
		resp = @cli.heartbeat().send(req)
		assert_not_nil(resp, "no response returned as sending the heartbeat")
		assert_not_nil(resp.heartbeat, "heartbeat can not be nil")
		assert_not_nil(resp.willExpireAt, "expiration time cannot be nil")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server message is not successful: #{resp.status}")
	end

	def test_04_enable_heartbeat
		req = Request::EnableHeartbeatRequest.new
		# build the request
		req.id = File.read("hbid.tmp").strip
		# send disable request
		resp = @cli.heartbeat().enable(req)
		assert_not_nil(resp, "no response returned as enabling the heartbeat")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("success", resp.status, "server message is not successful: #{resp.status}")		
	end

	def test_05_disable_heartbeat
		req = Request::DisableHeartbeatRequest.new
		# build the request
		req.id = File.read("hbid.tmp").strip
		# send disable request
		resp = @cli.heartbeat().disable(req)
		assert_not_nil(resp, "no response returned as sending the heartbeat")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("success", resp.status, "server message is not successful: #{resp.status}")		
	end

	def test_06_get_heartbeat
		req = Request::GetHeartbeatRequest.new
		# build the request
		req.id = File.read("hbid.tmp").strip
		# get the heartbeat
		resp = @cli.heartbeat().get(req)
		assert_not_nil(resp, "no response returned as getting the heartbeat")
		assert_not_nil(resp.id, "response does not include the heartbeat id")
		assert_equal("Heartbeat - 01", resp.name)		
		assert_equal("Active", resp.status)
		assert_equal("Heartbeat description is now updated", resp.description)
		assert(!resp.enabled?, "should be disabled")
		assert(resp.lastHeartbeat > 0, "last heartbeat: #{resp.lastHeartbeat}")
		assert_equal(resp.interval, 5.days, "interval is #{resp.interval}")
		assert(!resp.expired?, "shoud not be expired")
	end

	def test_07_list_heartbeats
		req = Request::ListHeartbeatsRequest.new
		# send the request, list the heartbeats
		resp = @cli.heartbeat().list(req)
		assert(resp.heartbeat_count > 0, "should exist one or more heartbeats")		
	end

	def test_08_delete_heartbeat
		req = Request::DeleteHeartbeatRequest.new
		# build the request
		req.id = File.read("hbid.tmp").strip
		# delete the heartbeat
		resp = @cli.heartbeat().delete(req)
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server status message should be 'success' but returned '#{resp.status}'")
	end
end
