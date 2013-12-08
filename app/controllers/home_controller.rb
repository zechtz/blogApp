class HomeController < ApplicationController

  before_filter :authorize_user, :only => :index
  before_filter :find_posts, :only => [:index, :refresh_posts]

  def index
  end

 def refresh_posts
  render :partial => 'post.html.erb', :locals => { :posts => @posts }
 end


 def find_posts
  	@posts = current_user.wall_posts
 end

 def get_post
  @post = Post.find_by_slug!(params[:id])
 end

end


