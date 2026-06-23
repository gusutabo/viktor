# P(Ck | X) = P(X|Ck) * P(Ck) / P(X)
class Bayes
  def initialize
    @categories = Hash.new { |h, k| h[k] = Hash.new(0) }
    @documents = Hash.new(0)
    @vocabulary = {}
  end

  def train(category, text)
    @documents[category] += 1

    tokenize(text).each do |word|
      @categories[category][word] += 1
      @vocabulary[word] = true
    end
  end

  def classify(text)
    raise 'No training data available' if @documents.empty?

    words = tokenize(text)

    scores = @documents.keys.map do |category|      
      score = Math.log(prior(category))

      words.each do |word|
        score += Math.log(likelihood(word, category))   
      end

      [category, score]
    end

    scores.max_by(&:last).first
  end

  private

  def tokenize(text)
    text.downcase.scan(/\p{Alnum}+/)
  end

  def prior(category)
    @documents[category].to_f / @documents.values.sum
  end

  def likelihood(word, category)
    word_count = @categories[category][word]
    total_words = @categories[category].values.sum
    
    (word_count + 1).to_f / (total_words + @vocabulary.size)
  end
end