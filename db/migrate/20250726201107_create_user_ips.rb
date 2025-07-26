class CreateUserIps < ActiveRecord::Migration[7.1]
  def change
    create_table :user_ips do |t|
      t.inet :ip_address, null: false

      t.timestamps
    end

    add_index :user_ips, :ip_address, unique: true
  end
end
