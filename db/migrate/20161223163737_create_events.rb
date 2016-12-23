class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :group, index: true, foreign_key: true
      t.boolean :raffled

      t.timestamps null: false
    end
  end
end
