class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :slug
  after_validation :generate_slug

  validates_presence_of :title, :uniqueness => true
  validates_presence_of :content

  
  scope :by_newest, order("created_at DESC")
  default_scope by_newest


  belongs_to :user
  has_many :comments, :dependent => :destroy

  # instruct rails to use the friendly slug as the url not the post id by 
  # overriding the to_param method
  def to_param
  	slug
  end

  # generate a friendly url for posts 
  def generate_slug
  	self.slug = title.parameterize
  end

  attr_accessible :comments_attributes
  accepts_nested_attributes_for :comments


  def user_name
    self.user.username.downcase
  end

end
