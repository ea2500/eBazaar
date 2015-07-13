class Product < ActiveRecord::Base
	
	belongs_to :user
  has_many :cart_items
  before_destroy :ensure_not_referenced 

	validates :name, :price, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}

	private
		def ensure_not_referenced
			if cart_items.empty?
				true
			else
				errors.add(:base, "cart items present")
			end
  	end

end
