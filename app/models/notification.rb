class Notification < ApplicationRecord
  belongs_to :sender, class_name: 'User', required: false
  belongs_to :recipient, class_name: 'User', required: false
  belongs_to :third, class_name: 'User', required: false
  belongs_to :task, required: false


  scope :unread, -> {
    where(read: nil)
  }


end
