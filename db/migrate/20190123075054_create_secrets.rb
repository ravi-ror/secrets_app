class CreateSecrets < ActiveRecord::Migration[5.2]
  def change
    create_table :secrets do |t|
      t.string :encrypted_secret,  null: false
			t.belongs_to :user
      t.timestamps
    end
    add_index :secrets, :encrypted_secret, unique: true
  end
end
