class Series < ActiveRecord::Base

  default_scope :order => 'created_at DESC'

  attr_accessible :name

  validates_presence_of :name, :user

  belongs_to :user
  has_many :submissions

end
