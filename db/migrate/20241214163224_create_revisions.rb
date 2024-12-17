class CreateRevisions < ActiveRecord::Migration[6.1]
  def change
    create_table :revisions do |t|
      t.references :daily, null: false, foreign_key: true
      t.integer :timestamp, null: false
      t.text :comment, null: false
      t.references :assigned_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
