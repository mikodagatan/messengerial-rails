class Job < ApplicationRecord
  belongs_to :client
  belongs_to :user, required: false
  belongs_to :status, required: false
  belongs_to :contact_person
  belongs_to :address
  belongs_to :resource, class_name: 'User', foreign_key: 'resource_id', optional: true
  belongs_to :request_type


  scope :by_required_date, ->  {
    order("required_date DESC")
  }

end
