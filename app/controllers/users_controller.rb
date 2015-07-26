class UsersController < ApplicationController
  before_action :bounce_not_logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :bounce_incorrect_user,     only: [:show, :edit, :update, :destroy]
  before_action :bounce_non_admin_user,     only: [:index]
  before_action :set_user,                  only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params_for_create)

    respond_to do |format|
      if @user.save
        @user.set_activation_digest
        UserMailer.account_activation(@user).deliver
        format.html { redirect_to root_url, notice: "Please check your email for your account activation..." }
        format.json { render action: 'show', status: :created, location: root_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params_for_update)
        format.html { redirect_to @user}
        format.json { head :no_content }
        flash[:success]='User was successfully updated.' 
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy unless @user.admin?
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params_for_create
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_url)
    end

    def user_params_for_update
      if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        params.require(:user).permit(:name, :email, :image_url, :password, :password_confirmation)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_url)
      end
      
    end

    def bounce_incorrect_user
      @user = User.find_by(id: params[:id])
      if @user
        unless @user == current_user or current_user.admin?
          flash[:failure]="only correct user or admin can do that"
          redirect_to(root_url)
        end
      else
        flash[:failure]="no such user found"
        redirect_to(root_url)
      end
    end
    
end
