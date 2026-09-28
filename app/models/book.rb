class Book < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
validates :body, presence: true, length: { maximum: 200 }
has_many :favorites, dependent: :destroy
has_many :book_comments, dependent: :destroy

def favorited_by?(user)
  favorites.exists?(user_id: user.id)
    end

    def self.looks(search, word)
  word = word.to_s

  case search
  when "perfect_match"
    where(title: word)
  when "forward_match"
    where("title LIKE ?", "#{word}%")
  when "backward_match"
    where("title LIKE ?", "%#{word}")
  when "partial_match"
    where("title LIKE ?", "%#{word}%")
  else
    all
  end
 end
end