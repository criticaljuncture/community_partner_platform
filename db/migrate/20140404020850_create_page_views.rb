class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.integer :user_id
      t.string  :method
      t.boolean :xhr
      t.string  :url, limit: 5000
      t.string  :referer, limit: 5000
      t.string  :remote_ip
      t.string  :user_agent
      t.integer :completed_in
      t.string  :controller
      t.string  :action
      t.string  :id_parameter
      t.integer :status
      t.integer :pid
      t.datetime :created_at
    end
  end
end
