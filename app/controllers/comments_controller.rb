class CommentsController < ApplicationController
  
  def new
  	@comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def create
  	@comment = Comment.new( params[:comment])
    respond_to do |format|
    	if @comment.save
    		format.html {redirect_to posts_path, :notice => "Successfully Commented"}
        format.js
    	else
    		render 'new'
    		flash[:alert] = "There was an error"
    	end
    end
  end


end
