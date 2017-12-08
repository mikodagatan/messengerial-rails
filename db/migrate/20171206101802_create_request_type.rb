class CreateRequestType < ActiveRecord::Migration[5.1]
  def up
    create_table :request_types do |t|
      t.string :name
      t.timestamps
    end
    execute "insert into request_types (name, created_at, updated_at) values ('Collections', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into request_types (name, created_at, updated_at) values ('Documents Pickup', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into request_types (name, created_at, updated_at) values ('SEC', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into request_types (name, created_at, updated_at) values ('Tax Payment', '#{ Time.now }', '#{ Time.now}')"
    execute "insert into request_types (name, created_at, updated_at) values ('BIR', '#{ Time.now }', '#{ Time.now}')"
  end
  def down
    drop_table :request_types
  end
end
