class Comic < ApplicationRecord
  belongs_to :publisher
  has_many :comic_authors
  has_many :authors, through: :comic_authors

  validates :title, presence: true
  validates :genre, presence: true
  validates :published_on, presence: true
end
