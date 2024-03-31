class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { minimum: 2 }
  validates :profile, length: { maximum: 200 }

  mount_uploader :avatar, AvatarUploader
  
  has_many :users
  has_many :reservations
end
