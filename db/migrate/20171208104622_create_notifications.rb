class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :task_id
      t.string  :notification_type
      t.datetime :read

      t.timestamps
    end
  end
end
