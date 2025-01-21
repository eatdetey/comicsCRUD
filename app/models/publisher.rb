class Publisher < ApplicationRecord
  has_many :comics

  validates :name, presence: true, uniqueness: true
end
