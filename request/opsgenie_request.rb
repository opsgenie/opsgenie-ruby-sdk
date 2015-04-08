class Fixnum
		def days
			{ "interval" => self, "intervalUnit" => "days"}
		end
		def hours
			{ "interval" => self, "intervalUnit" => "hours"}
		end
		def minutes
			{ "interval" => self, "intervalUnit" => "minutes"}
		end
end

module Request
	module Status
		OPEN = "open"
		ACKED = "acked"
		UNACKED = "unacked"
		SEEN = "seen"
		NOT_SEEN = "notseen"
		CLOSED = "closed"
	end


	class CreateAlertRequest

		attr_accessor 	:apiKey, :message, :teams,
						:alias, :description, :recipients,
						:actions, :source, :tags,
						:details, :entity, :user, :note

		def initialize
			@apiKey = nil
			@message = nil
			@teams ||= []
			@alias = nil
			@description = nil
			@recipients ||= []
			@actions ||= []
			@source = nil
			@tags ||= []
			@details ||= []
			@entity = nil
			@user = nil
			@note = nil
		end

		def to_map
			h = {
				"apiKey" 	=> @apiKey,
				"message" 	=> @message,
				"teams"		=> @message,
				"alias"		=> @alias,
				"description"	=> @description,
				"recipients"	=> @recipients,
				"actions"	=> @actions,
				"source"	=> @source,
				"tags"		=> @tags,
				"details"	=> @details,
				"entity"	=> @entity,
				"user"		=> @user,
				"note"		=> @note
			}
			# delete empty or nil vals
			h.delete_if{ |k,v| v.nil? or (v.instance_of?(Array) and v.empty?) }
		end

		def endpoint
			"/v1/json/alert"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end

	class GetAlertRequest
		attr_accessor :apiKey, :id, :alias, :tinyId
		def initialize
			@apiKey = nil
			@id = nil
			@alias = nil
			@tinyId = nil
		end

		def to_map
			h = {
				"apiKey" => @apiKey,
				"id" => @id,
				"alias" => @alias,
				"tinyId" => @tinyId
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/alert"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end

	class AcknowledgeAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:user, :note, :source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{|k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/acknowledge"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class ListAlertsRequest
		attr_accessor 	:apiKey, :createdAfter, :createdBefore,
						:updatedAfter, :updatedBefore, :limit,
						:status, :sortBy, :order
		def initialize
			@apiKey = nil
			@createdAfter = nil
			@createdBefore = nil
			@updatedAfter = nil
			@updatedBefore = nil
			@limit = nil
			@status = nil
			@sortBy = nil
			@order = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"createdAfter"	=> @createdAfter,
				"createdBefore"	=> @createdBefore,
				"updatedAfter"	=> @updatedAfter,
				"updatedBefore" => @updatedBefore,
				"limit"		=> @limit,
				"status"	=> @status,
				"sortBy"	=> @sortBy,
				"order"		=> order
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/alert"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class ListAlertNotesRequest

		attr_accessor :apiKey, :id, :alias,
						:limit, :order, :lastKey
		def initialize
			@apiKey = nil
			@id = nil
			@alias = nil
			@limit = nil
			@order = nil
			@lastKey = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"id"		=> @id,
				"alias"		=> @alias,
				"limit"		=> @limit,
				"order"		=> @order,
				"lastKey"	=> @lastKey
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/note"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class AddNoteAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:note, :user, :source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@note = nil
			@user = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey, 
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"note"		=> @note,
				"user"		=> @user,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/note"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class ListAlertLogsRequest
		attr_accessor 	:apiKey, :id, :alias,
						:limit, :order, :lastKey
		def initialize
			@apiKey = nil
			@id = nil
			@alias = nil
			@limit = nil
			@order = nil
			@lastKey = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"id"		=> @id,
				"alias"		=> @alias,
				"limit"		=> @limit,
				"order"		=> @order,
				"lastKey"	=> @lastKey
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/log"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class ListAlertRecipientsRequest
		
		attr_accessor :apiKey, :id, :alias

		def initialize
			@apiKey = nil
			@id = nil
			@alias = nil
		end
		def to_map
			h = {
				"apiKey" 	=> @apiKey,
				"id"		=> @id,	
				"alias"		=> @alias
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/recipient"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class RenotifyAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:recipients, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@recipients = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"recipients" 	=> @recipients,
				"user"			=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? or (v.instance_of?(Array) and v.empty?) }
		end
		def endpoint
			"/v1/json/alert/renotify"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end


	class TakeOwnershipAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:user, :note, :source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/takeOwnership"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class AssignOwnerAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:owner, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@owner = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"owner"		=> @owner,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/assign"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class AddTeamAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:team, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@team = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"team"		=> @team,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/team"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class AddRecipientAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:recipient, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@recipient = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"recipient"	=> @recipient,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/recipient"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end	

	class ExecuteActionAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:action, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@action = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"action"	=> @action,
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/executeAction"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end	

	class AttachFileAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:attachment, :user, :note,
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@attachment = nil
			@user = nil
			@note = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"attachment"	=> File.new(@attachment, 'rb'),
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source,
				"multipart"	=> true
			}
			h.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/attach"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end	
	
	class CloseAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:user, :note, :notify
						:source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@user = nil
			@note = nil
			@notify = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"notify"	=> (@notify.join(',') unless @notify.nil?),
				"user"		=> @user,
				"note"		=> @note,
				"source"	=> @source,				
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/alert/close"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class DeleteAlertRequest
		attr_accessor 	:apiKey, :alertId, :alias,
						:user, :source
		def initialize
			@apiKey = nil
			@alertId = nil
			@alias = nil
			@user = nil
			@source = nil
		end
		def to_map
			h = {
				"apiKey"	=> @apiKey,
				"alertId"	=> @alertId,
				"alias"		=> @alias,
				"user"		=> @user,
				"source"	=> @source,				
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/alert"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end
	#
	# Heartbeat Requests
	#
	#

	class AddHeartbeatRequest
		attr_accessor 	:apiKey, :name, :interval,
						:description, :enabled
		def initialize
			@apiKey = nil
			@name = nil
			@interval = nil			
			@description = nil
			@enabled = nil	
		end

		def to_map
			h = {
				"apiKey" => @apiKey,
				"name"	=> @name,
				"interval" => (@interval['interval']),
				"intervalUnit"	=> (@interval['intervalUnit']),
				"description"	=> @description,
				"enabled"		=> @enabled
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/heartbeat"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end

	class UpdateHeartbeatRequest
		attr_accessor 	:apiKey, :name, :interval,
						:description, :enabled, :id
		def initialize
			@apiKey = nil
			@id = nil
			@name = nil
			@interval = nil			
			@description = nil
			@enabled = nil	
		end

		def to_map
			h = {
				"apiKey" => @apiKey,
				"id" => @id,
				"name"	=> @name,
				"interval" => (@interval['interval']),
				"intervalUnit"	=> (@interval['intervalUnit']),
				"description"	=> @description,
				"enabled"		=> @enabled
			}
			h.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/heartbeat"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end

	class SendHeartbeatRequest
		attr_accessor :apiKey, :name
		def initialize
			@apiKey = nil
			@name = nil
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"name"	=> @name
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/heartbeat/send"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class DisableHeartbeatRequest
		attr_accessor :apiKey, :name, :id
		
		def initialize
			@apiKey = nil
			@name = nil
			@id = nil
		end

		def to_map
			{
				"apiKey" 	=> @apiKey,
				"name"		=> @name,
				"id"		=> @id
			}.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/heartbeat/disable"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end
	class EnableHeartbeatRequest
		attr_accessor :apiKey, :name, :id
		
		def initialize
			@apiKey = nil
			@name = nil
			@id = nil
		end

		def to_map
			{
				"apiKey" 	=> @apiKey,
				"name"		=> @name,
				"id"		=> @id
			}.delete_if{ |k,v| v.nil? }
		end

		def endpoint
			"/v1/json/heartbeat/enable"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end	

	class GetHeartbeatRequest
		attr_accessor :apiKey, :name, :id

		def initialize
			@apiKey = nil
			@name = nil
			@id = nil
		end

		def to_map
			{
				"apiKey" => @apiKey,
				"name"	=> @name,
				"id"	=> @id
			}.delete_if{ |k,v| v.nil? }
		end
		
		def endpoint
			"/v1/json/heartbeat"	
		end

		def request_uri(domain)
			domain + endpoint
		end
	end

	class ListHeartbeatsRequest
		attr_accessor :apiKey
		def initialize
			@apiKey = nil
		end
		def to_map
			{ "apiKey" => @apiKey }.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/heartbeat"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class DeleteHeartbeatRequest
		
		attr_accessor :apiKey, :name, :id

		def initialize
			@apiKey = nil
			@name = nil
			@id = nil
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"name" => @name,
				"id" => @id
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/heartbeat"
		end

		def request_uri(domain)
			domain + endpoint
		end
	end
	#
	# Policy API Requests
	#

	class EnablePolicyRequest
		attr_accessor :apiKey, :name, :id
		def initialize
			@apiKey = nil
			@id = nil
			@name = nil			
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"id" => @id,
				"name" => @name
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/policy/enable"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class DisablePolicyRequest
		attr_accessor :apiKey, :name, :id
		def initialize
			@apiKey = nil
			@id = nil
			@name = nil			
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"id" => @id,
				"name" => @name
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/alert/policy/disable"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	#
	# Integration API Requests
	#
	class EnableIntegrationRequest
		attr_accessor :apiKey, :name, :id
		def initialize
			@apiKey = nil
			@id = nil
			@name = nil			
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"id" => @id,
				"name" => @name
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/integration/enable"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

	class DisableIntegrationRequest
		attr_accessor :apiKey, :name, :id
		def initialize
			@apiKey = nil
			@id = nil
			@name = nil			
		end
		def to_map
			{
				"apiKey" => @apiKey,
				"id" => @id,
				"name" => @name
			}.delete_if{ |k,v| v.nil? }
		end
		def endpoint
			"/v1/json/integration/disable"
		end
		def request_uri(domain)
			domain + endpoint
		end
	end

end
