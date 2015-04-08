require_relative '../client/opsgenie_client'
require_relative '../request/opsgenie_request'
require 'test/unit'
require 'yaml'

class TestAlertClient < Test::Unit::TestCase
	
	def setup
		@cli = Client::OpsGenieClient.new 
		conf = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))
		api_key = conf[conf['env']]['apiKey']
		@cli.apiKey = api_key
		@sampleUser = conf[conf['env']]['user']
		@sampleTeam = conf[conf['env']]['team']
		@sampleRecipient = conf[conf['env']]['recipient']
		@sampleAttachment = conf[conf['env']]['attachedfile']
	end

	def test_01_create_an_alert
		req = Request::CreateAlertRequest.new
		# build a request
		req.message = "Test alert by Ruby SDK"
		req.recipients = ['selcuk.bozdag@gmail.com']
		req.source = "Ruby SDK"
		req.description = "The quick brown fox jumped over the lazy dog"
		req.actions = ['ping', 'pong']
		req.tags = ['test', 'ruby sdk']
		# create the alert
		resp = @cli.alert().create(req)
		# the response should success
		assert_not_nil(resp, "no response returned")
		assert_not_nil(resp.alertId, "alert id is nil")
		assert_equal(200, resp.code, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "response status is #{resp.status}")
		assert_equal("alert created", resp.message, "response message does not mean the alert is created: #{resp.message}")
		assert(resp.took > 0, "response time took less than or equal to zero, it's awkward: #{resp.took}")
		# write the alert id to a file
		File.open("alertid.tmp", 'w')  { |file|	file.puts resp.alertId }
	end
	
	def test_02_get_the_alert
		req = Request::GetAlertRequest.new
		# build a request
		req.id = File.read("alertid.tmp").strip
		# get the alert
		resp = @cli.alert().get(req)
		assert_not_nil(resp, "no response returned as getting the alert")
		@alert_id = resp.id
	end

	def test_03_ack_the_alert
		req = Request::AcknowledgeAlertRequest.new		
		# build a request
		req.alertId = File.read("alertid.tmp").strip
		# ack the alert
		resp = @cli.alert().acknowledge(req)
		assert_not_nil(resp, "no response returned as acknowledging the alert")
		assert_equal(200, resp.code, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "response status is #{resp.status} expecting 'successful'")
	end

	def test_04_list_alerts
		req = Request::ListAlertsRequest.new
		# build the request
		req.limit = 5
		req.status = Request::Status::OPEN
		# list the alerts
		resp = @cli.alert().list_alerts(req)
		assert_not_nil(resp, "no response returned as listing the alerts")
		assert_equal(5, resp.alert_count)
	end

	def test_05_add_note_to_alert
		req = Request::AddNoteAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.note = "Attention please"
		# add the note
		resp = @cli.alert().add_note(req)
		assert_not_nil(resp, "no response returned as adding a note to the alert #{req.alertId}")
		assert(resp.success?, "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")
	end

	def test_06_list_alert_notes
		req = Request::ListAlertNotesRequest.new
		# build the request
		req.id = File.read("alertid.tmp").strip
		# list the notes
		resp = @cli.alert().list_alert_notes(req)
		assert_not_nil(resp, "no response returned as listing the alert notes")
		assert(resp.took > 0, "response time took less than or equal to zero, it's awkward: #{resp.took}")
	end

	def test_07_list_alert_logs
		req = Request::ListAlertLogsRequest.new
		# build the request
		req.id = File.read("alertid.tmp").strip
		# list the logs
		resp = @cli.alert().list_logs(req)
		assert_not_nil(resp, "no response returned as listing logs for the alert #{req.id}")
		assert(!resp.logs.empty?, "there should be at least one log message")
	end

	def test_08_list_alert_recipients
		req = Request::ListAlertRecipientsRequest.new
		# build the request
		req.id = File.read("alertid.tmp").strip
		# list the recipients
		resp = @cli.alert().list_recipients(req)
		assert_not_nil(resp, "no response returned as listing the recipients of the alert #{req.id}")
		assert(!resp.users.empty?, "there should be at least one recipient of the alert #{req.id}")
	end

	def test_09_renotify_recipients
		req = Request::RenotifyAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		# renotify the recipients
		resp = @cli.alert().renotify(req)
		assert_not_nil(resp, "no response returned as renotifying the recipients of the alert #{req.alertId}")
		assert( resp.success? , "server responded with error code #{resp.code}")
		assert_equal( "successful", resp.status, "server responded status message: #{resp.status}")
	end

	def test_10_take_ownership
		req = Request::TakeOwnershipAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		# take the ownership
		resp = @cli.alert().take_ownership(req)
		assert_not_nil(resp, "no response returned as taking the ownership of the alert #{req.alertId}")
		assert( resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")
	end

	def test_11_assign_request
		req = Request::AssignOwnerAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.owner = @sampleUser
		# assign the ownership
		resp = @cli.alert().assign_owner(req)
		assert_not_nil(resp, "no response returned as assigning the ownership of the alert #{req.alertId}")
		assert( resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")		
	end

	def test_12_add_team
		req = Request::AddTeamAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.team = @sampleTeam
		# add the team
		resp = @cli.alert().add_team(req)
		assert_not_nil(resp, "no response returned as adding the team to the alert #{req.alertId}")
		assert( resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")				
	end

	def test_13_add_recipient
		req = Request::AddRecipientAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.recipient = @sampleRecipient
		# add the team
		resp = @cli.alert().add_recipient(req)
		assert_not_nil(resp, "no response returned as adding recipient to the alert #{req.alertId}")
		assert(resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")						
	end

	def test_14_execute_action
		req = Request::ExecuteActionAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.action = "ping"
		# execute the action
		resp = @cli.alert().execute_action(req)
		assert_not_nil(resp, "no response returned as executing ping action. alert id: #{req.alertId}")
		assert(resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")								
	end

	def test_15_attach_file
		req = Request::AttachFileAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		req.attachment = @sampleAttachment
		# attach the file
		resp = @cli.alert().attach_file(req)
		assert_not_nil(resp, "no response returned as attaching the file, alert id: #{req.alertId}")
		assert(resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")								
	end

	def test_16_close_alert
		req = Request::CloseAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		# close the alert
		resp = @cli.alert().close(req)
		assert_not_nil(resp, "no response returned as closing the alert with id: #{req.alertId}")
		assert(resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")										
	end

	def test_17_delete_alert
		req = Request::DeleteAlertRequest.new
		# build the request
		req.alertId = File.read("alertid.tmp").strip
		# close the alert
		resp = @cli.alert().delete(req)
		assert_not_nil(resp, "no response returned as deleting the alert with id: #{req.alertId}")
		assert(resp.success? , "server responded with error code #{resp.code}")
		assert_equal("successful", resp.status, "server responded status message: #{resp.status}")												
	end
end