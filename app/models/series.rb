class Series < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name, :user

  belongs_to :user

  has_many :submissions

end
