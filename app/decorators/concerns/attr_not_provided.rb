# wraps optional elements in a 'not provided' helper if not present
module AttrNotProvided
  extend ActiveSupport::Concern

  def has_many_associations
    @assoc ||= model.class.reflect_on_all_associations(:has_many).map(&:name)
  end

  class_methods do
    def attr_not_provided(*attrs)
      options = attrs.last

      if options.is_a?(Hash)
        attrs.pop
        method = options.delete(:method)
        association = options.fetch(:association) { false }
        seperator = options.fetch(:seperator) { ', ' }
      else
        method = nil
      end

      attrs.each do |attr|
        define_method attr do
          if model.send(attr).present?
            if association
              if has_many_associations.include?(attr)
                model.send(attr).map{|assoc| assoc.send(method)}.join(seperator)
              else
                model.send(attr).send(method)
              end
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
