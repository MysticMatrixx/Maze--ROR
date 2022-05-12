class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role
  validates :phone, presence: true, uniqueness: true, length: { minimum: 10, maximum: 10 } # { case_sensitive: false }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # private

  def assign_default_role
    add_role(:user) if roles.blank?
  end
  #
  # enum role: %i[user admin]
  # after_initialize :set_default_role, if: :new_record?
  # def set_default_role
  #   self.role ||= :user
  # end
end
