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

	def accept_friendship_request
	    @friendship = Friendship.accept(@user, @friend)
	    if @friendship
	      redirect_to root_url, :notice => "You are now friends with #{@friend.username}"
	    else
	      flash[:error] = "There was an error"
	    end
  	end

  	def destroy_friendship
	    @friendship_to_destroy = Friendship.breakup(@user, @friend)
	    if @friendship_to_destroy
	      redirect_to my_friends_user_path(@user), :notice => "You are no longer friends with #{@friend.user_name}"
	    else
	      flash[:alert] = "Could not unfriend #{@friend.user_name}"
	   end
  	end

	def pending_friendships
		@pending = @user.friendships_to_accept_or_reject
	end

    def show_friends
    	@friends = @user.accepted_friends
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
