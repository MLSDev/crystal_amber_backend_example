require "moonstone"

class Api::BaseController < ApplicationController
  include Moonstone::Api::Controller

  LAYOUT = nil

  def index
    respond_with(200) do
      json(decorated_paginated_collection.to_json)
    end
  end

  def show
    resource = find_resource

    if resource.nil?
      respond_with(404) do
        json({ errors: { base: "Record was not found" } }.to_json)
      end
    else
      respond_with(200) do
        json(resource.decorate.as_json.to_json)
      end
    end
  end

  def create
    if create_params.valid?
      resource = build_resource

      if resource.save
        respond_with(201) do
          json(resource.decorate.as_json.to_json)
        end
      else
        respond_with(422) do
          json(decorated_errors_of(resource).to_json)
        end
      end
    else
      respond_with(400) do
        json(decorated_errors_of_params(create_params).to_json)
      end
    end
  end

  private def create_params
    #
    # => unfoturnately, Amber doesnt parse nested params, need to parse it by our own :(
    #
    # => there was some cool implementation of permitting params in the way like { requried_key: [:param1, :param2] }
    #
    # if permitted_create_params.keys.size == 1
    #   required_key = permitted_create_params.keys.first

    #   # params[required_key.to_s].validation do
    #   #   permitted_create_params[required_key].each do |param|
    #   #     optional(params) { |_| true }
    #   #   end
    #   # end
    #   pp "====> #{ params[required_key.to_s].class }"

    #   params
    # else
    #   Amber.logger.debug "permitted_create_params should contain 1 required key"

    #   params
    # end

    #
    # =>
    #
    params.validation do
      permitted_create_params.each do |param|
        optional(param) { |_| true }
      end
    end
  end
end
