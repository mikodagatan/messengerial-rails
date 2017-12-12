class Client < ApplicationRecord
  has_many  :target_clients
  has_many  :contact_persons, through: :target_clients
  has_many   :addresses, through: :target_clients

  validates :name, presence: true
end
