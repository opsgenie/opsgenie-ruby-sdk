require_relative './opsgenie_alert_client'
require_relative './opsgenie_heartbeat_client'
require_relative './opsgenie_policy_client'
require_relative './opsgenie_integration_client'

module Client
	class OpsGenieClient
		
		attr_accessor :proxyConf, :httpConf, :apiKey

		def initialize
			@proxyConf = nil
			@httpConf = nil		
			@apiKey = nil	
		end

		def configureClient(cli)
			cli.domain = domain
			cli.apiKey = @apiKey
			cli.proxyConf = @proxyConf
			cli.httpConf = @httpConf
			cli			
		end

		def alert
			configureClient(Client::OpsGenieAlertClient.new)
		end

		def heartbeat
			configureClient(Client::OpsGenieHeartbeatClient.new)
		end

		def policy
			configureClient(Client::OpsGeniePolicyClient.new)
		end

		def integration
			configureClient(Client::OpsGenieIntegrationClient.new)
		end

		def domain
			"https://api.opsgenie.com"		
		end
	end

end