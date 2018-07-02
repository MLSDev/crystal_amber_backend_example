class EmptyModel
  def as_json(*args)
    {} of Symbol => String
  end
end

module Decorator
  def decorate(context = DeocoratorContextAlias.new)
    #
    #
    #
    if    self.is_a?(User)
      UserDecorator.new self, context
    elsif self.is_a?(Session)
      SessionDecorator.new self, context
    #
    #
    #
    else
      EmptyModel.new
    end
  end
end
