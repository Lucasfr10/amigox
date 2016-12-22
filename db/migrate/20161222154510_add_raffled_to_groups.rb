class AddRaffledToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :raffled, :boolean, :default => false
  end
end
