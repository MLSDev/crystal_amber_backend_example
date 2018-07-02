class Api::SessionsController < Api::BaseController
  private def build_resource
    Session.new(create_params.to_h).tap do |session|
      #
      # NOTE: here is little trick. `setter` is not used while attributes are assigning via `new` calling.
      #
      session.email    = create_params["email"]
      session.password = create_params["password"]
    end
  end

  private def permitted_create_params
    [:email, :password]
  end
end
