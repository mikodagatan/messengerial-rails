class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :city_town
      t.string :province
      t.string :country
      t.string :zipcode
      t.integer :target_client_id

      t.timestamps
    end
  end
end
