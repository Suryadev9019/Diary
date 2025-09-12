class DiaryEntry < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  before_save :analyze_mood

  # Convenience method to access mood_category as mood
  def mood
    mood_category
  end

  # Setter method to set mood_category via mood
  def mood=(value)
    self.mood_category = value
  end

 
 private

  def analyze_mood
   result = MoodAnalyzer.analyze(content)
   self.mood_category = result[:category]
  end
end
