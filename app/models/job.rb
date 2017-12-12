class Job < ApplicationRecord
  after_create_commit { NotificationBroadcastJob.perform_later self }

  belongs_to :client
  belongs_to :user, required: false
  belongs_to :status, required: false
  belongs_to :contact_person
  belongs_to :address
  belongs_to :target_client
  belongs_to :resource, class_name: 'User', foreign_key: 'resource_id', optional: true
  belongs_to :request_type


  scope :by_required_date, ->  {
    order("required_date DESC")
  }

end
