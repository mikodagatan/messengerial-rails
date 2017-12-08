class Client < ApplicationRecord
  has_many  :contact_persons
  has_many   :addresses

  accepts_nested_attributes_for :addresses

  validates :name, presence: true
end
