class AddProjectIdToDailies < ActiveRecord::Migration[7.1]
  def change
    add_column :dailies, :project_id, :integer
  end
end
