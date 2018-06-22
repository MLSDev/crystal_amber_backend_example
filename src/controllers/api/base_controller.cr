module Api
  class BaseController < Amber::Controller::Base
    LAYOUT = nil

    def errors_of(resource)
      resource_errors = {} of String => Array(String)

      resource.errors.each do |granite_error|
        resource_errors[granite_error.field.to_s] ||= [] of String
        resource_errors[granite_error.field.to_s].push granite_error.message.to_s
      end

      logger.info resource_errors

      {
        errors: resource_errors,
      }
    end

    def create
      resource = build_resource

      respond_with do
        if resource.save
          json(resource.to_json)
        else
          json(errors_of(resource).to_json)
        end
      end
    end
  end
end
