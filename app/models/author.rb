class Author < ApplicationRecord
  has_many :comic_authors
  has_many :comics, through: :comic_authors

  validates :name, presence: true, uniqueness: true
end
