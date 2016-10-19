class AddUserColumnPushCode < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :push_code, :string
  end
end
