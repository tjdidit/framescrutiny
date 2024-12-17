class ChangeTimestampToStringInRevisions < ActiveRecord::Migration[7.0]
  def change
    change_column :revisions, :timestamp, :string
  end
end
