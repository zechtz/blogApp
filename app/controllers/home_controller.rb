class HomeController < ApplicationController
  def index
  	@posts = Post.find(:all, :order => 'id desc') 
  end
end