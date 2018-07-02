abstract class BaseDecorator
  property! context : DeocoratorContextAlias

  def initialize(model, context)
    @model   = model

    @context = context
  end

  abstract def as_json

  delegate to_json, to: :as_json

  forward_missing_to model
end
