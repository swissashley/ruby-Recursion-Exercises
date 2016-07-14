require 'set'

class WordChainer
  attr_accessor :dictionary, :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
    @current_words = []
    @all_seen_words = []
  end

  # def adj_words(source)
  #   adj_words_arr = []
  #   source.length.times do |i|
  #     regex = /#{source[0...i]}[a-z]#{source[(i+1)..-1]}/
  #     dictionary.each do |word|
  #       adj_words_arr << word unless (regex =~ word).nil? || (word.length != source.length)
  #     end
  #   end
  #   adj_words_arr
  # end

  def adj_words(word)
      # variable name *masks* (hides) method name; references inside
      # `adjacent_words` to `adjacent_words` will refer to the variable,
      # not the method. This is common, because side-effect free methods
      # are often named after what they return.
      adjacent_words = []

      # NB: I gained a big speedup by checking to see if small
      # modifications to the word were in the dictionary, vs checking
      # every word in the dictionary to see if it was "one away" from
      # the word. Can you think about why?
      word.each_char.with_index do |old_letter, i|
        ('a'..'z').each do |new_letter|
          # Otherwise we'll include the original word in the adjacent
          # word array
          next if old_letter == new_letter

          new_word = word.dup
          new_word[i] = new_letter

          adjacent_words << new_word if dictionary.include?(new_word)
        end
      end

      adjacent_words
    end

  def run(source, target)
    @current_words << source
    @all_seen_words = {source => nil}

    until @current_words.count == 0 || @all_seen_words.has_key?(target)
      new_current_words = []
      @current_words.each do |current_word|

        adj_words(current_word).each do |adj_word|
          next if @all_seen_words.has_key?(adj_word)
          new_current_words << adj_word

          # use hash to link adj word with current word
          @all_seen_words[adj_word] = current_word
        end
      end
      p "New current words: #{new_current_words}"
      @current_words = new_current_words
    end
    p "Run ends!"

    build_path(target)
  end

  def build_path(target)
    path = []
    current_word = target
    until current_word.nil?
      path << current_word
      current_word = @all_seen_words[current_word]
    end

    path.reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  wc = WordChainer.new("dictionary.txt")
  p wc.run("duck","ruby")
end
