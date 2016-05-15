class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

    def show
      # binding.pry
      @user = User.find_by(id: params[:id])
      @favorite_objects = @user.global_data_objects
    end

    def edit
      @user = User.find_by(id:params[:id])
    end

    def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

    private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :password,
                                   :email,
                                   :phone,
                                   :location)
    end
end
