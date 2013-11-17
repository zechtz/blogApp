class PostsController < ApplicationController
	before_filter :find_post, :only => [:edit, :update, :destroy, :show, :correct_user]
	before_filter :authorize_user, :except => [:show, :index]
	before_filter :current_user, :only => [:edit, :destroy]
	before_filter :correct_user, :only => [:edit, :destroy]
	
  def show
  	@comment = @post.comments.build
    @comments = @post.comments.all 
  end

  def new
  	@post = current_user.posts.build
  end

  def create
  	@post = current_user.posts.build(params[:post])
  	if @post.save
  		redirect_to root_url, :notice => 'Successfully created a new blog post'
  	else
  		render 'new'
  		flash[:alert] = "Could not create post"
  	end  	
  end

  def edit
  end

  def update
  	if @post.update_attributes(params[:post])
  		redirect_to root_url, :notice => 'Successfully updated the post'
  	else
  		render 'edit'
  		flash[:alert] = "There was an error updating post"
  	end
  end

  def destroy
  	if @post.delete
  		redirect_to root_url, :notice => 'Successfully deleted'
  	end
  end

  def find_post
  	@post = Post.find_by_slug(params[:id])
  end

  def authorize_user
  	redirect_to log_in_path, :notice => "You must be logged in to do that" unless logged_in?
  end

  def correct_user
  	redirect_to root_url, :notice => "You are not authorized to do that" unless is_admin? || can_manage(@post)
  end

end
