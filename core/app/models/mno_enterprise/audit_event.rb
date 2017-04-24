module MnoEnterprise
  class AuditEvent < BaseResource
    property :created_at, type: :time
    property :updated_at, type: :time

    def formatted_details
      case details
        when String
          details
        when Hash
          format_serialized_details
        else
          nil
      end
    end

    def format_serialized_details
      AUDIT_LOG_CONFIG.fetch('events', {}).fetch(key, '') % details.symbolize_keys
    rescue KeyError => e
      e.message
      # details.inspect
    end

  end
end

