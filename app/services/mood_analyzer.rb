class MoodAnalyzer
  # Define positive and negative keywords for basic sentiment analysis
  POSITIVE_WORDS = %w[
    happy excited joy love amazing wonderful great fantastic excellent
    perfect beautiful awesome incredible outstanding brilliant marvelous
    delighted thrilled pleased satisfied grateful thankful blessed
    cheerful optimistic hopeful confident proud successful accomplished
    peaceful calm relaxed comfortable content serene blissful euphoric
    inspired motivated energized refreshed vibrant alive fantastic
  ].freeze

  NEGATIVE_WORDS = %w[
    sad angry depressed upset frustrated disappointed worried anxious
    stressed terrible awful horrible disgusting hate despise loathe
    miserable devastating heartbroken crushed defeated hopeless helpless
    exhausted drained overwhelmed confused lost scared frightened terrified
    lonely isolated rejected abandoned betrayed hurt painful agonizing
    furious enraged irritated annoyed disgusted revolted sick tired
  ].freeze

  NEUTRAL_WORDS = %w[
    okay fine normal average typical usual regular standard ordinary
    same routine daily work meeting task project assignment
  ].freeze

  def initialize(text)
    @text = text.to_s.downcase
    @words = clean_text(@text).split
  end

  # Main method to analyze mood
  def analyze
    return { score: 0.0, category: 'neutral' } if @words.empty?

    positive_score = calculate_positive_score
    negative_score = calculate_negative_score
    
    # Calculate overall mood score (-1.0 to 1.0)
    total_words = @words.length
    mood_score = (positive_score - negative_score).to_f / total_words
    
    # Clamp score between -1.0 and 1.0
    mood_score = [[-1.0, mood_score].max, 1.0].min
    
    {
      score: mood_score.round(2),
      category: determine_category(mood_score)
    }
  end

  private

  def clean_text(text)
    # Remove punctuation and convert to lowercase
    text.gsub(/[^\w\s]/, ' ').squeeze(' ').strip
  end

  def calculate_positive_score
    positive_count = 0
    
    @words.each do |word|
      if POSITIVE_WORDS.include?(word)
        positive_count += 1
      end
    end
    
    positive_count
  end

  def calculate_negative_score
    negative_count = 0
    
    @words.each do |word|
      if NEGATIVE_WORDS.include?(word)
        negative_count += 1
      end
    end
    
    negative_count
  end

  def determine_category(score)
    case score
    when 0.1..1.0
      if score >= 0.5
        'very_positive'
      elsif score >= 0.2
        'positive'
      else
        'slightly_positive'
      end
    when -1.0..-0.1
      if score <= -0.5
        'very_negative'
      elsif score <= -0.2
        'negative'
      else
        'slightly_negative'
      end
    else
      'neutral'
    end
  end

  # Class method for easy usage
  def self.analyze(text)
    new(text).analyze
  end

  # Method to get mood emoji for display
  def self.mood_emoji(category)
    case category
    when 'very_positive'
      '😄'
    when 'positive'
      '😊'
    when 'slightly_positive'
      '🙂'
    when 'neutral'
      '😐'
    when 'slightly_negative'
      '🙁'
    when 'negative'
      '😢'
    when 'very_negative'
      '😞'
    else
      '😐'
    end
  end

  # Method to get mood color for display
  def self.mood_color(category)
    case category
    when 'very_positive'
      'text-green-600'
    when 'positive'
      'text-green-500'
    when 'slightly_positive'
      'text-green-400'
    when 'neutral'
      'text-gray-500'
    when 'slightly_negative'
      'text-yellow-500'
    when 'negative'
      'text-red-500'
    when 'very_negative'
      'text-red-600'
    else
      'text-gray-500'
    end
  end
end
