class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)

    @user = User.new
      .tap { |su| su.username = user_params[:username] }
      .tap { |su| su.password = user_params[:password] }

    if @user.login_valid?
      session[:admin] = true
      redirect_to '/orders'
    else
      @user.password = nil
      flash[:notice] = 'Sorry, invalid login.'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to orders_path
  end
end
