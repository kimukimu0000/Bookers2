class User < ApplicationRecord
has_many :owned_groups,
         class_name: "Group",
         foreign_key: "owner_id",
         dependent: :destroy

has_many :group_users, dependent: :destroy
has_many :groups, through: :group_users

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

def self.looks(search, word)
  word = word.to_s

  case search
  when "perfect_match"
    where(name: word)
  when "forward_match"
    where("name LIKE ?", "#{word}%")
  when "backward_match"
    where("name LIKE ?", "%#{word}")
  when "partial_match"
    where("name LIKE ?", "%#{word}%")
  else
    all
    end
  end
end