module Api
  class UsersController < BaseController
    private def build_resource
      User.new \
        email: create_params[:email]
    end

    private def create_params
      params.validation do
        required(:email)                 { |p| p.is_a? String }
        optional(:password)              { |p| p.is_a? String }
        optional(:password_confirmation) { |p| p.is_a? String }
      end
    end
  end
end
