class Door < ApplicationRecord
  belongs_to :vehicle

  validates :is_sliding, inclusion: [true, false]
end
