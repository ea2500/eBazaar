class AddOrderToCartItems < ActiveRecord::Migration
  def change
    add_reference :cart_items, :order, index: true
  end
end
