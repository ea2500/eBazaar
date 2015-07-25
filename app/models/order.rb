class Order < ActiveRecord::Base

	has_many :cart_items, dependent: :destroy

	PAYMENT_TYPES=["credit cart", "check", "purchase order"]
	
	validates :name, :address, :email, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES
	
end
