class AddMoodFieldsToDiaryEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :diary_entries, :mood_score, :float
    add_column :diary_entries, :mood_category, :string
  end
end
