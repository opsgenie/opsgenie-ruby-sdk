require_relative '../client/opsgenie_client'
require_relative '../request/opsgenie_request'
require 'test/unit'
require 'yaml'

class TestIntegrationClient < Test::Unit::TestCase

	def setup
		@cli = Client::OpsGenieClient.new 
		conf = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))
		api_key = conf[conf['env']]['apiKey']
		@cli.apiKey = api_key
	end

	def test_01_enable_integration
		req = Request::EnableIntegrationRequest.new
		req.name = "sdk_test_integration"
		resp = @cli.integration().enable(req)
		assert(resp.success?, "server responded with error message #{resp.status}")
		assert(resp.took > 0, "taken time is less than or equal to zero, it's awkward")
	end

	def test_02_disable_integration
		req = Request::DisableIntegrationRequest.new
		req.name = "sdk_test_integration"
		resp = @cli.integration().disable(req)
		assert(resp.success?, "server responded with error message #{resp.status}")
		assert(resp.took > 0, "taken time is less than or equal to zero, it's awkward")
	end
end