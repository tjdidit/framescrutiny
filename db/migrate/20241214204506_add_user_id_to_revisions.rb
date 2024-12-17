class AddUserIdToRevisions < ActiveRecord::Migration[7.1]
  def change
    add_column :revisions, :user_id, :integer
  end
end
