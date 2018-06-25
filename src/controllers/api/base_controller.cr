require "moonstone"

module Api
  class BaseController < ApplicationController
    include Moonstone::Api::Controller

    LAYOUT = nil

    def create
      if create_params.valid?
        resource = build_resource

        if resource.save
          respond_with(201) do
            json(resource.to_json)
          end
        else
          respond_with(422) do
            json(decorated_errors_of(resource).to_json)
          end
        end
      else
        params_errors = {} of String => Array(String)

        create_params.errors.each do |error|
          # [e.param, e.value, e.message]
          params_errors[error.param] ||= [] of String
          params_errors[error.param].push error.message
        end

        respond_with(400) do
          json(params_errors.to_json)
        end
      end
    end

    private def create_params
      params.validation do
        permitted_create_params.each { |param| optional(param) { |p| true } }
      end
    end
  end
end
