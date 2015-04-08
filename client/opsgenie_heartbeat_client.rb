require 'rest_client'
require 'json'
require_relative '../response/opsgenie_response'

module Client

	class OpsGenieHeartbeatClient
		attr_accessor :proxyConf, :httpConf, :domain, :apiKey

		def initialize
			@proxyConf = nil
			@httpConf = nil
			@domain = nil
			@apiKey = nil
		end

		def add(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::AddHeartbeatResponse::NewFromJsonString(resp)			
		end

		def update(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)			
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::UpdateHeartbeatResponse::NewFromJsonString(resp)			
		end

		def send(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)			
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::SendHeartbeatResponse::NewFromJsonString(resp)						
		end
		
		def enable(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::EnableHeartbeatResponse::NewFromJsonString(resp)									
		end

		def disable(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::DisableHeartbeatResponse::NewFromJsonString(resp)									
		end

		def get(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::GetHeartbeatResponse::NewFromJsonString(resp)
		end

		def list(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::ListHeartbeatsResponse::NewFromJsonString(resp)
		end

		def delete(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.delete uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::DeleteHeartbeatResponse::NewFromJsonString(resp)			
		end
	end

end
