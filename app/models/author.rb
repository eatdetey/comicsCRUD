class Author < ApplicationRecord
  has_many :comic_authors
  has_many :comics, through: :comic_authors
  before_destroy :ensure_not_referenced

  validates :name, presence: true, uniqueness: true

  private

  def ensure_not_referenced
    if comics.any?
      errors.add(:base, "Cannot delete author because they are associated with comics.")
      throw(:abort)
    end
  end
end
