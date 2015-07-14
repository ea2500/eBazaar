class ChangeBodyTypeInProducts < ActiveRecord::Migration
  def change
  	change_column :products, :body, :text
  end
end
