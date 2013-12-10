class PostsController < ApplicationController
	
  before_filter :find_post, :only => [:edit, 
                                      :update, 
                                      :destroy, 
                                      :show, 
                                      :ensure_correct_user
                                    ]

	before_filter :authorize_user, :except => [:show, :index, :new_post_comment]
	before_filter :current_user, :only => [:edit, :destroy]
	before_filter :ensure_correct_user, :only => [:edit, :destroy]
  # before_filter :show_post_comments, :only => [:reload_comments]
	
  def show
    @comments = @post.comments.all
  end

  def new
  	@post = current_user.posts.build
  end

  def new_post_comment
    @post = Post.find_by_slug!(params[:id])
    @comment = @post.comments.build
    respond_to do |format|
      format.js
    end
  end

  def create
  	@post = current_user.posts.build(params[:post])
  	if @post.save
      track_activity(@post)
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
      track_activity(@post)
  		redirect_to root_url, :notice => 'Successfully updated the post'
  	else
  		render 'edit'
  		flash[:alert] = "There was an error updating post"
  	end
  end

  def destroy
  	if @post.delete
      track_activity(@post)
  		redirect_to root_url, :notice => 'Successfully deleted'
  	end
  end

  def find_post
  	@post = Post.find_by_slug(params[:id])
  end

  def ensure_correct_user
  	redirect_to root_url, :notice => "You are not authorized to do that" unless is_admin? || can_manage(@post)
  end

  # def show_post_comments
  #   @comments = @post.comments
  # end

end
