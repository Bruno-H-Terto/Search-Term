class ChangeTermToCitext < ActiveRecord::Migration[7.1]
  def change
    change_column :searches, :term, :citext
  end
end
