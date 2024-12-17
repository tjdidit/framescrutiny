class AddConstraintToRevisionsTimestamp < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE revisions ADD CONSTRAINT valid_ntsc_timestamp CHECK (timestamp ~ '^\\d{2}:\\d{2}:\\d{2}:\\d{2}$')
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE revisions DROP CONSTRAINT valid_ntsc_timestamp
    SQL
  end
end
