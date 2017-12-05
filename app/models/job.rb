class Job < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :status
  belongs_to :contact_person
  belongs_to :address
  belongs_to :resource, class_name: 'User', foreign_key: 'resource_id', optional: true


  scope :by_required_date, ->  {
    order("required_date DESC")
  }
end
