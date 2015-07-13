class ProductsController < ApplicationController
  before_action :bounce_not_logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :bounce_incorrect_user,     only: [:edit, :update, :destroy]
  before_action :set_product,               only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if current_user.admin?
      @products = Product.order(:user_id).paginate(page: params[:page], per_page: 15)
    else
      @products = current_user.products.paginate(page: params[:page], per_page: 5)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.create(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product}
        format.json { render action: 'show', status: :created, location: @product }
        flash[:success]='Product was successfully created.' 
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product }
        format.json { head :no_content }
        flash[:success]='Product was successfully updated.'
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :user_id, :image_url, :body)
    end

    def bounce_incorrect_user
      @product = Product.find_by(id: params[:id])
      if @product
        @user = @product.user
        if @user
          unless @user == current_user or current_user.admin?
            flash[:failure]="only correct user or admin can do that"
            redirect_to(root_url)
          end
        else
          flash[:failure]="no such user found"
          redirect_to(root_url)  
        end
      else
        flash[:failure]="no such product found"
        redirect_to(root_url)
      end
    end

end
