class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  attr_accessible :action, :trackable

  # rails g resource activity user:belongs_to action trackable:belongs_to trackable_type
end
