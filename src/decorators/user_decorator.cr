class UserDecorator < BaseDecorator
  property! model : User

  def as_json(*args)
    {
      id:         model.id,
      email:      model.email,
      created_at: model.created_at
    }
  end
end
