class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :term
      t.references :user_ip, null: false, foreign_key: true

      t.timestamps
    end

    add_index :searches, [ :user_ip_id, :term ], unique: true
  end
end
