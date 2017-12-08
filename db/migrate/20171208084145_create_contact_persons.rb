class CreateContactPersons < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_number
      t.integer :client_id
    end
  end
end
