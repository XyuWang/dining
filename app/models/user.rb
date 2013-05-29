class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone, :name, :address

  include RoleModel
  roles :admin, :storer

  scope :storers, select { |user| user.storer?}

  has_one :store
  has_one :cart
  has_many :line_items
  has_many :orders
end
