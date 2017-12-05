class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.date :required_date
      t.integer :client_id
      t.integer :user_id
      t.integer :address_id
      t.text :request_description
      t.integer :contact_person_id
      t.text :notes_to_resource
      t.integer :resource_id
      t.integer :status_id
      t.text :resource_notes

      t.timestamps
    end
  end
end
