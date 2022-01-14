class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create]

    before_action :require_correct_user, only: [:edit, :delete, :update]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @reviews = @user.reviews
    end

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to @user, notice: "Account Updated!"
        else
            render :edit
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user, notice: "Thank you for signing up!!"
        else
            render :new
        end
    end

    def destroy
        @user.destroy 
        session[:user_id] = nil
        redirect_to movies_url, danger: "Account Successfully Deleted"
    end


end

private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_correct_user
        @user = User.find(params[:id])
        redirect_to root_url, unless current_user?(@user)

    end

end

