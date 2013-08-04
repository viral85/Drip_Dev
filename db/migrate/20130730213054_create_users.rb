class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.integer :login_count
      t.datetime :last_logged_in_at

      t.timestamps
    end
  end
end
