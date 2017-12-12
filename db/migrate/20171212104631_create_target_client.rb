class CreateTargetClient < ActiveRecord::Migration[5.1]
  def change
    create_table :target_clients do |t|
      t.string :name
      t.integer :client_id
      
      t.timestamps
    end
  end
end
