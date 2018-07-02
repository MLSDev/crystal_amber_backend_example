class SessionDecorator < BaseDecorator
  property! model : Session

  def as_json(*args)
    {
      token: model.token
    }
  end
end
