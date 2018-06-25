module Api
  class UsersController < BaseController
    private def build_resource
      User.new create_params.to_h
    end

    private def permitted_create_params
      [
        :email, :password, :password_confirmation
      ]
    end
  end
end
