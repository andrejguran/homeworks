class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:uco]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :uco, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :works
  has_many :tasks
end
