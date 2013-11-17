class FriendshipsController < ApplicationController
	
	before_filter :authorize_user, :setup_friends

	def index
		@friendships = User.all
	end

	# Send a friend request.
	# We'd rather call this "request", but that's not allowed by Rails.
	def create
		friendship = Friendship.request(@user, @friend)
		redirect_to browse_people_user_path, :notice => "Friendship request sent"
	end

	# reject friendship request
	def reject_friendship
		rejected_friendship = Friendship.breakup(@user, @friend)
		redirect_to browse_people_user_path, :notice => "Friendship request rejected"
	end

	private
	def setup_friends
		@user = current_user
		@friend = User.find(params[:id])
	end

	def authorize_user
  		redirect_to log_in_path, :notice => "You must be logged in to do that" unless logged_in?
 	end
end
