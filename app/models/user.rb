class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader

  has_many  :posts, :inverse_of => :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of   :first_name, :last_name
  validates_processing_of :avatar
  validates :avatar, file_size: { less_than: 0.5.megabytes }

  def name
    "#{first_name} #{last_name}" if first_name && last_name
  end
end
