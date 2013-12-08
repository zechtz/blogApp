class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user 
  		session[:user_id] = user.id
      redirect_back_or root_path
  		flash[:notice] = 'Successfully Logged In'
  	else
  		flash[:alert] = "Wrong Password / Email Combination"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, :notice => 'Successfully Logged Out'
  end
end
