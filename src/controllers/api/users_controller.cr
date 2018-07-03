class Api::UsersController < Api::BaseController
  private def build_resource
    User.new(create_params.to_h).tap do |user|
      user.password              = create_params["password"]?
      user.password_confirmation = create_params["password_confirmation"]?
    end
  end

  private def permitted_create_params
    [
      :email, :password, :password_confirmation
    ]
  end

  private def find_resource
    if params["id"]?
      User.find_by(id: params["id"])
    else
      context.current_user
    end
  end

  private def decorated_paginated_collection
    {
      collection: users.map { |user| user.decorate.as_json }
    }
  end

  private def users
    User.all
  end
end
