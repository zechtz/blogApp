class User < ActiveRecord::Base
	require 'bcrypt'
  attr_accessible :email, :password_hash, :password_salt, :username, 
                  :password, :password_confirmation, :admin
  attr_accessor :password
  has_many :posts
  has_many :friendships
  has_many :friends, :through => :friendships
  before_save :encrypt_password, :unless => Proc.new {|u| u.password.blank?}

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
    username.downcase
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

end
