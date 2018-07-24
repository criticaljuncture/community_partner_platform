class AddIdentifierToQualityElements < ActiveRecord::Migration[4.2]
  def change
    add_column :quality_elements, :identifier, :string
  end
end
