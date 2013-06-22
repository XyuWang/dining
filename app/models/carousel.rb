class Carousel < ActiveRecord::Base
  attr_accessible :sequence, :message, :image

  default_scope order("sequence")

  has_attached_file :image, :styles => { :medium => "930x300>"}, :default_url => "/images/:style/missing.png"
end
