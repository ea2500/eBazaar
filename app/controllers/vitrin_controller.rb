class VitrinController < ApplicationController
	def index
		@query=params[:search_text]
		
		if @query
			@query=params[:search_text].split.uniq
			@products=Product.all
			@query.each do |q|
				temp1=Product.where("name ILIKE ?", "%#{q}%")
				temp2=Product.where("body ILIKE ?", "%#{q}%")
				@products = @products & (temp1 | temp2)
			end

		  	id_list=[]
		  	@products.each { |product|  id_list << product.id  }
		  	@products=Product.where(id: id_list).order(:price)

		else
			@products=Product.all.order(:price)
			#@products=Product.all.order("RANDOM()")
		end
		@products=@products.paginate(page: params[:page], per_page: 10)
	end
end
