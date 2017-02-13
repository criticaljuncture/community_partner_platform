class GeoJsonSerializer < BaseSerializer
  attributes :type, :features

  def type
    "FeatureCollection"
  end

  def features
    ActiveModel::Serializer::ArraySerializer.new(
      object.object,
      serializer: object.instance_options[:serializer]
    )
  end
end
