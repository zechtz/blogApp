class User < ActiveRecord::Base
	require 'bcrypt'
  attr_accessible :email, :password_hash, :password_salt, :username, 
                  :password, :password_confirmation, :admin
  attr_accessor :password, :remember_me

  has_many :activities
  has_many :posts
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :comments
  before_save :encrypt_password, 
              :unless => Proc.new {|u| u.password.blank?}
  

  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :username, :uniqueness => true, :on => :create
  validates :email, :uniqueness => true, :on => :create
  validates_presence_of :username

  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  # def update_attributes(params)
  #   if params[:password].blank?
  #     params.delete :password
  #     params.delete :password_confirmation
  #     super params
  #   end    
  # end

  def password_changed?
    !@password.blank?    
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def user_name
    username
  end

  def self.make_admin(user)
    admin_user = find_by_id(user)
    admin_user = user.toggle(:admin)
    admin_user.save 
  end

  # these are friendship requests that we need to either accept or reject
  def friendships_to_accept_or_reject
    friends = []
    user_friendship_requests.each do |user|
      friends.push(User.find(user))
    end
    friends
  end

  # people who are already our friends
  def accepted_friends
    the_friends = []
    user_accepted_friends.each do |friend|
      the_friends.push(User.find(friend))
    end
    the_friends
  end

  def pending_friends
    friends = []
    the_friends = Friendship.find(user_friendship_requests)
    the_friends.each do |friend|
      friends<< friend.friend_id
    end
    friends
  end

  def user_pending_friendships
    self.friendships.where(:status => 'pending')
  end

  def user_friendship_requests
    friend_requests = self.friendships.where(:status => 'requested').pluck(:friend_id)
  end

  def user_accepted_friends
    the_aceepted_friends = self.friendships.where(:status => 'accepted').pluck(:friend_id)
  end

  # user should only see posts by himself and his friends 
  def wall_posts
    # in ruby you can add arrays by just doing array1 + array2 
    # and that will return a combined array containing all the stuff 
    # in both arrays

    (friends_posts + my_posts).sort {|v1,v2| v2.id <=> v1.id}
   
  end

  # loop through user's posts and add them to an arry of posts then return that array
  def my_posts
    the_posts = []
    self.posts.each do |post|
      the_posts.push(post)
    end
    the_posts
  end

  private
  # loop through each friend, then add each friend's posts to an array and return
  # the array of friends posts 
  def friends_posts
    post_feeds = []
    accepted_friends.each do |friend|
      post_feeds += friend.posts
    end
    post_feeds
  end

end
