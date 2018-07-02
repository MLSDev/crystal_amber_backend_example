class Api::UsersController < Api::BaseController
  private def build_resource
    User.new(create_params.to_h).tap do |user|
      user.password = create_params["password"]
    end
  end

  private def permitted_create_params
    [
      :email, :password, :password_confirmation
    ]
  end
end
