# provides methods for accessing the active_model_serializer version
# of the model without overwriting the default rails to_json, as_json
module ModelSerializable
  def serialized_to_json(options={})
    serializer(options).to_json(options)
  end

  def serializer_as_json(options={})
    serializer(options).as_json(options)
  end

  private

  def serializer(options)
    options.fetch(:serializer){ active_model_serializer }.new(self)
  end
end
