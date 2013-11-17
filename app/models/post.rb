class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :slug
  after_validation :generate_slug

  validates_presence_of :title, :uniqueness => true
  validates_presence_of :content

  belongs_to :user
  has_many :comments, :dependent => :destroy

  def to_param
  	slug
  end

  def generate_slug
  	self.slug = title.parameterize
  end

  attr_accessible :comments_attributes
  accepts_nested_attributes_for :comments #, :reject_if => lambda { |a| a[:advocate_name].blank? }

  def user_name
    self.user.username.downcase
  end

end
