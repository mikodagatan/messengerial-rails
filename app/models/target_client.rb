class TargetClient < ApplicationRecord
  belongs_to :client
  has_many   :contact_persons
  has_many   :addresses

  accepts_nested_attributes_for :addresses

  validates :name, presence: true
end
