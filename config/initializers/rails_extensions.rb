class ActiveRecord::Base
  def self.hattr(*args)
    human_attribute_name(*args)
  end
end

ActiveRecord::Base.extend ActiveHash::Associations::ActiveRecordExtensions
