class Client < ApplicationRecord
  has_many  :contact_persons
  has_many   :addresses
end
