class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :context

  validates :context, :commentable, presence: true

  belongs_to :commentable, polymorphic: true
end
