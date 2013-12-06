class CommentsController < ApplicationController
 
  def new
  	@comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def create
  	@comment = Comment.new( params[:comment])
  	@post = Post.find(params[:comment][:post_])
    respond_to do |format|
    	if @comment.save
    		format.html {redirect_to post_path(@post), :notice => "Successfully Commented"}
        format.js {}
    	else
    		render 'new'
    		flash[:alert] = "There was an error"
    	end
    end
  end

end
