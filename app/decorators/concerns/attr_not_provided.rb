# wraps optional elements in a 'not provided' helper if not present
module AttrNotProvided
  extend ActiveSupport::Concern

  class_methods do
    def attr_not_provided(*attrs)
      options = attrs.last

      if options.is_a?(Hash)
        attrs.pop
        method = options.delete(:method)
        association = options.fetch(:association) { false }
      else
        method = nil
      end

      attrs.each do |attr|
        define_method attr do
          if model.send(attr).present?
            if association
              model.send(attr).send(method)
            elsif method
              method.call(model.send(attr))
            else
              model.send(attr)
            end
          else
            h.not_provided
          end
        end
      end
    end
  end
end
