require "json"

module OpsGenieResponse
	class CreateAlertResponse
		attr_reader :alertId, :message, :status, :code, :took

		def initialize(attrs)
			@alertId = attrs['alertId']
			@message = attrs['message']
			@status = attrs['status']
			@code = attrs['code']
			@took =  attrs['took']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			CreateAlertResponse.new(parsedAttrs)
		end
	end

	class GetAlertResponse
		attr_reader :tags, :count, :status, :teams,
					:recipients, :tinyId, :alertAlias,
					:entity, :id, :updatedAt, :message,
					:details, :source, :description,
					:createdAt, :owner, :actions
		def initialize(attrs)
			@tags = attrs['tags']
			@count = attrs['count']
			@status = attrs['status']
			@teams = attrs['teams']
			@recipients = attrs['recipients']
			@tinyId = attrs['tinyId']
			@alertAlias = attrs['alias']
			@entity = attrs['entity']
			@id = attrs['id']
			@updatedAt = attrs['updatedAt']
			@message = attrs['message']
			@details = attrs['details']
			@source = attrs['source']
			@description = attrs['description']
			@createdAt = attrs['createdAt']
			@isSeen = attrs['isSeen']
			@acked = attrs['acknowledged']
			@owner = attrs['owner']
			@actions = attrs['actions']
			@systemData = attrs['systemData']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			GetAlertResponse.new(parsedAttrs)
		end

		def seen?
			@isSeen			
		end

		def acknowledged?
			@acknowledged
		end

		def integrationType
			@systemData['integrationType'] if @systemData.has_key? 'integrationType'
		end

		def integrationId
			@systemData['integrationId'] if @systemData.has_key? 'integrationId'
		end

		def integrationName
			@systemData['integrationName'] if @systemData.has_key? 'integrationName'
		end

		def acknowledgedAt
			@systemData['ackTime'] if @systemData.has_key? 'ackTime'
		end

		def acknowledgedBy
			@systemData['acknowledgedBy'] if @systemData.has_key? 'acknowledgedBy'
		end

		def closedAt
			@systemData['closeTime'] if @systemData.has_key? 'closeTime'
		end

		def closedBy
			@systemData['closedBy'] if @systemData.has_key? 'closedBy'
		end
	end

	class AcknowledgeAlertResponse
		attr_reader 	:status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AcknowledgeAlertResponse.new(parsedAttrs)
		end
	end

	class AlertsListElement
		attr_reader :id, :alertAlias, :message,
					:status, :createdAt, :updatedAt,
					:tinyId

		def initialize(attrMap)
			@id = attrMap['id']
			@alertAlias = attrMap['alias']
			@message = attrMap['message']
			@status = attrMap['status']
			@isSeen = attrMap['isSeen']
			@isAcked = attrMap['acknowledged']
			@createdAt = attrMap['createdAt']
			@updatedAt = attrMap['updatedAt']
			@tinyId = attrMap['tinyId']
		end

		def seen?
			@isSeen
		end

		def acknowledged?
			@isAcked			
		end
	end

	class ListAlertsResponse
		attr_reader :alerts

		def initialize(attrs)
			@alerts = Array.new
			attrs['alerts'].each { |attrMap| @alerts << AlertsListElement.new(attrMap) }
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ListAlertsResponse.new(parsedAttrs)
		end
		def alert_count
			@alerts.length
		end
	end

	class AlertNoteElement
		attr_reader :note, :owner, :createdAt
		
		def initialize(attrMap)
			@note = attrMap['note']
			@owner = attrMap['owner']
			@createdAt = attrMap['createdAt']			
		end
	end

	class ListAlertNotesResponse
		attr_reader :lastKey, :took, :notes

		def initialize(attrs)
			@lastKey = attrs['lastKey']
			@took = attrs['took']
			@notes = Array.new
			attrs['notes'].each{ |attrMap| @notes << AlertNoteElement.new(attrMap) }
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ListAlertNotesResponse.new(parsedAttrs)
		end
		def note_count
			@notes.length
		end
	end

	class AddNoteAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AddNoteAlertResponse.new(parsedAttrs)
		end
		def success?
			@code == 200
		end
	end

	class AlertLogElement
		attr_reader :log, :logType, :owner, :createdAt
		def initialize(attrMap)
			@log = attrMap['log']
			@logType = attrMap['logType']
			@owner = attrMap['owner']
			@createdAt = attrMap['createdAt']
		end
	end

	class ListAlertLogsResponse
		attr_reader :lastKey, :logs
		def initialize(attrs)
			@lastKey = attrs['lastKey']
			@logs = Array.new
			attrs['logs'].each{ |attrMap| @logs << AlertLogElement.new(attrMap) }
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ListAlertLogsResponse.new(parsedAttrs)
		end
		def log_count
			@logs.length
		end
	end

	class AlertRecipientUser
		attr_reader :username, :state, :method, :stateChangedAt

		def initialize(attrMap)
			@username = attrMap['username']
			@state = attrMap['state']
			@method = attrMap['method']
			@stateChangedAt = attrMap['stateChangedAt']
		end
	end

	class	AlertRecipientGroup
		attr_reader :name, :users
		def initialize(name, users)
			@name = name
			@users = users
		end
	end

	class AlertRecipientUserGroup
		attr_reader :groups
		def initialize(attrMap)
			@groups = Array.new
			attrMap.each do |group_name, users_array|
				users = Array.new
				users_array.each{ |user_attrs| users << AlertRecipientUser.new(user_attrs) }
				group = AlertRecipientGroups.new( group_name, users )
			end
		end
		def group_by_name(name)
			@groups.find{ |group| group.name == name }
		end
	end

	class ListAlertRecipientsResponse
		
		attr_reader :users, :groups

		def initialize(attrs)
			@users = Array.new
			@user_groups = Array.new

			attrs['users'].each { |attrMap| @users << AlertRecipientUser.new(attrMap) }
			attrs['groups'].each { |attrMap| @user_groups << AlertRecipientUserGroup.new(attrMap) }
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ListAlertRecipientsResponse.new(parsedAttrs)
		end
	end

	class RenotifyAlertResponse
		
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			RenotifyAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end

	class TakeOwnershipAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			TakeOwnershipAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end

	class AssignOwnerAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AssignOwnerAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end
	class AddTeamAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AddTeamAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end

	class AddRecipientAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AddRecipientAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end	

	class ExecuteActionAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ExecuteActionAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end	

	class AttachFileAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AttachFileAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end	

	class CloseAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			CloseAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end		

	class DeleteAlertResponse
		attr_reader :status, :code

		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']	
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			DeleteAlertResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end		

	#
	# Heartbeat responses
	#
	class AddHeartbeatResponse
		
		attr_reader :id, :status, :code

		def initialize(attrs)
			@id = attrs['id']
			@status = attrs['status']
			@code = attrs['code']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			AddHeartbeatResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end
	class UpdateHeartbeatResponse
		
		attr_reader :id, :status, :code

		def initialize(attrs)
			@id = attrs['id']
			@status = attrs['status']
			@code = attrs['code']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			UpdateHeartbeatResponse.new(parsedAttrs)
		end

		def success?
			@code == 200
		end
	end

	class SendHeartbeatResponse
		attr_reader :heartbeat, :willExpireAt, :status, :code
		def initialize(attrs)
			@heartbeat = attrs['heartbeat']
			@willExpireAt = attrs['willExpireAt']
			@status = attrs['status']
			@code = attrs['code']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			SendHeartbeatResponse.new(parsedAttrs)
		end
		def success?
			@code == 200
		end
	end

	class DisableHeartbeatResponse

		attr_reader :status, :code
		
		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			DisableHeartbeatResponse.new(parsedAttrs)			
		end

		def success?
			@code == 200
		end
	end

	class EnableHeartbeatResponse
		attr_reader :status, :code
		
		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']
		end

		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			EnableHeartbeatResponse.new(parsedAttrs)			
		end

		def success?
			@code == 200
		end
	end	

	class GetHeartbeatResponse

		attr_reader :id, :name, :status, :description,
					:lastHeartbeat
		def initialize(attrs)
			@id = attrs['id']
			@name = attrs['name']
			@status = attrs['status']
			@description = attrs['description']
			@isEnabled = attrs['enabled']
			@lastHeartbeat = attrs['lastHeartbeat']
			@interval_n = attrs['interval']
			@intervalUnit_s = attrs['intervalUnit']
			@isExpired = attrs['expired']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			GetHeartbeatResponse.new(parsedAttrs)			
		end

		def enabled?
			@isEnabled
		end

		def expired?
			@isExpired
		end

		def interval
			case @intervalUnit_s
			when "minutes"
				@interval_n.minutes
			when "hours"
				@interval_n.hours
			when "days"
				@interval_n.days
			else
				nil
			end
		end
	end

	class ListHeartbeatsResponse
		attr_reader :heartbeats

		def initialize(attrs)
			@heartbeats = Array.new
			attrs['heartbeats'].each{ |hbmap| @heartbeats << GetHeartbeatResponse.new(hbmap) }
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			ListHeartbeatsResponse.new(parsedAttrs)			
		end
		def heartbeat_count
			@heartbeats.length
		end
	end

	class DeleteHeartbeatResponse
		attr_reader :status, :code
		def initialize(attrs)
			@status = attrs['status']
			@code = attrs['code']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			DeleteHeartbeatResponse.new(parsedAttrs)			
		end
		def success?
			@code == 200
		end
	end

	#
	# Policy API Responses
	#

	class EnablePolicyResponse
		attr_reader :status, :took
		def initialize(attrs)
			@status = attrs['status']
			@took = attrs['took']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			EnablePolicyResponse.new(parsedAttrs)			
		end
		def success?
			@status == "success"
		end
	end

	class DisablePolicyResponse
		attr_reader :status, :took
		def initialize(attrs)
			@status = attrs['status']
			@took = attrs['took']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			DisablePolicyResponse.new(parsedAttrs)			
		end
		def success?
			@status == "success"
		end
	end

	#
	# Integration API Responses
	#
	class EnableIntegrationResponse
		attr_reader :status, :took
		def initialize(attrs)
			@status = attrs['status']
			@took = attrs['took']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			EnableIntegrationResponse.new(parsedAttrs)			
		end
		def success?
			@status == "success"
		end
	end

	class DisableIntegrationResponse
		attr_reader :status, :took
		def initialize(attrs)
			@status = attrs['status']
			@took = attrs['took']
		end
		def self.NewFromJsonString(str)
			parsedAttrs = JSON.parse(str)
			DisableIntegrationResponse.new(parsedAttrs)			
		end
		def success?
			@status == "success"
		end
	end

end
