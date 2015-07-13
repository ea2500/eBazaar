class AddDummyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dummy, :string
  end
end
