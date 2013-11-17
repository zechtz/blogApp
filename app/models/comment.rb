class Comment < ActiveRecord::Base
  attr_accessible :comment_content, :user_name, :post_id

  validates_presence_of :comment_content
  validates_presence_of :user_name

  belongs_to :post
  attr_accessible :post_attributes
  accepts_nested_attributes_for :post
end
