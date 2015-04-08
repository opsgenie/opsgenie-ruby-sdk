require 'rest_client'
require 'json'
require_relative '../response/opsgenie_response'

module Client

	class OpsGenieAlertClient

		attr_accessor :proxyConf, :httpConf, :domain, :apiKey

		def initialize
			@proxyConf = nil
			@httpConf = nil
			@domain = nil
			@apiKey = nil
		end

		def create(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json		
			OpsGenieResponse::CreateAlertResponse::NewFromJsonString(resp)
		end

		def get(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::GetAlertResponse::NewFromJsonString(resp)
		end

		def acknowledge(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::AcknowledgeAlertResponse::NewFromJsonString(resp)
		end

		def list_alerts(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::ListAlertsResponse::NewFromJsonString(resp)
		end

		def list_alert_notes(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::ListAlertNotesResponse::NewFromJsonString(resp)
		end

		def add_note(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::AddNoteAlertResponse::NewFromJsonString(resp)
		end

		def list_logs(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::ListAlertLogsResponse::NewFromJsonString(resp)
		end

		def list_recipients(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.get uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::ListAlertRecipientsResponse::NewFromJsonString(resp)
		end

		def renotify(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::RenotifyAlertResponse::NewFromJsonString(resp)
		end

		def take_ownership(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::TakeOwnershipAlertResponse::NewFromJsonString(resp)
		end

		def assign_owner(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::AssignOwnerAlertResponse::NewFromJsonString(resp)
		end

		def add_team(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::AddTeamAlertResponse::NewFromJsonString(resp)			
		end

		def add_recipient(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::AddRecipientAlertResponse::NewFromJsonString(resp)			
		end
		def execute_action(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::ExecuteActionAlertResponse::NewFromJsonString(resp)			
		end

		def attach_file(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map, :accept => :json
			OpsGenieResponse::AttachFileAlertResponse::NewFromJsonString(resp)			
		end

		def close(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.post uri, ogreq.to_map.to_json, :content_type => :json, :accept => :json
			OpsGenieResponse::CloseAlertResponse::NewFromJsonString(resp)						
		end

		def delete(ogreq)
			ogreq.apiKey = @apiKey
			uri = ogreq.request_uri(@domain)
			resp = RestClient.delete uri, :params => ogreq.to_map, :accept => :json
			OpsGenieResponse::DeleteAlertResponse::NewFromJsonString(resp)									
		end
	end

end