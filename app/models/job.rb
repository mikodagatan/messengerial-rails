class Job < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :status
  belongs_to :resource, class_name: 'User', foreign_key: 'resource_id', optional: true
end
