class HomeController < ApplicationController

  before_filter :find_posts, :only => [:index, :refresh_posts]
  before_filter :get_post, :only => [:vote_up, :vote_down]

  def index
  	
  end

 def refresh_posts
  render :partial => 'post.html.erb', :locals => { :posts => @posts }
 end

 protected
 def find_posts
  @posts = Post.find(:all, :order => 'id desc') 
 end

 def get_post
  	 @post = Post.find_by_slug!(params[:id])
  end 

end


