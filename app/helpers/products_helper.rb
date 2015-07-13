module ProductsHelper
	def associated_orders_count(product)
		list=[]
		product.cart_items.each { |item| list << item.order if item.order}
		return list.length
	end
end
