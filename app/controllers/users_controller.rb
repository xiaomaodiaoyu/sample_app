class UsersController < ApplicationController
  # By default, before filters apply to every action in a controller, 
  # so here we restrict the filter to act only on the :edit and :update actions
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] 
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		# Handle a successful save.
  		flash[:success] = "Welcome to the Sample App!"
  		# can omit the user_path in the redirect
  		# redirect to the user show page.
  		redirect_to @user
    else
    	render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user      
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

private

    def signed_in_user
      unless  signed_in?
        store_location  
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
