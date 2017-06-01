class AddIdentifierToQualityElements < ActiveRecord::Migration
  def change
    add_column :quality_elements, :identifier, :string
  end
end
