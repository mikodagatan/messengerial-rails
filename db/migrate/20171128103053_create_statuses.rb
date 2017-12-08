class CreateStatuses < ActiveRecord::Migration[5.1]
  def up
    create_table :statuses do |t|
      t.string :name
      t.timestamps
    end
    execute "insert into statuses (name, created_at, updated_at) values ('Open', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into statuses (name, created_at, updated_at) values ('Scheduled', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into statuses (name, created_at, updated_at) values ('Completed', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into statuses (name, created_at, updated_at) values ('With Issues', '#{ Time.now }', '#{ Time.now}')"
  end
  def down
    drop_table :statuses
  end
end
