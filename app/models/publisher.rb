class Publisher < ApplicationRecord
  has_many :comics
  before_destroy :ensure_not_referenced

  validates :name, presence: true, uniqueness: true

  private

  def ensure_not_referenced
    if comics.any?
      errors.add(:base, "Cannot delete publisher because it is associated with comics.")
      throw(:abort)
    end
  end
end
