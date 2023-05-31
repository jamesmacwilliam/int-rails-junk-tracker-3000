class PartStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
