require 'rest_client'
require 'json'
require_relative '../response/opsgenie_response'

module Client

	class OpsGenieIntegrationClient
		attr_accessor :proxyConf, :httpConf, :domain, :apiKey

		def initialize
			@proxyConf = nil
			@httpConf = nil
			@domain = nil
			@apiKey = nil
		end
	
		def enable(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::EnableIntegrationResponse::NewFromJsonString(resp)				
		end

		def disable(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::DisableIntegrationResponse::NewFromJsonString(resp)				
		end
	end
end