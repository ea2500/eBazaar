module CartsHelper
	def current_cart
		@cart ||= Cart.find_by(id: session[:cart_id])
	end
	# create a cart if does not exist in first item adding
    def set_cart
      unless current_cart
        @cart=Cart.create
        session[:cart_id]=@cart.id
      end
    end

    def number_of_cart_items(cart)
      if cart
        cart.cart_items.inject(0){|sum, item| sum+item.quantity }
      else
        0
      end
    end
    
end
