class AddOnDeleteCascadeToSearches < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :searches, :user_ips

    add_foreign_key :searches, :user_ips, on_delete: :cascade
  end
end
