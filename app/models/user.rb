class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :books, dependent: :destroy
has_one_attached :profile_image

validates :name, presence: true, length: { in: 2..20 }, uniqueness: true
validates :introduction, length: { maximum: 50 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships,
         class_name: "Relationship",
         foreign_key: "follower_id",
         dependent: :destroy

has_many :followings,
         through: :relationships,
         source: :followed

has_many :reverse_of_relationships,
         class_name: "Relationship",
         foreign_key: "followed_id",
         dependent: :destroy

has_many :followers,
         through: :reverse_of_relationships,
         source: :follower

         def follow(user)
  relationships.create(followed_id: user.id)
end

def unfollow(user)
  relationships.find_by(followed_id: user.id)&.destroy
end

def following?(user)
  followings.include?(user)
end
end