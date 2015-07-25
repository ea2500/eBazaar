module ProductsHelper
	def associated_orders(product)
		list=[]
		product.cart_items.each { |item| list << item.order if item.order }
	end
end
