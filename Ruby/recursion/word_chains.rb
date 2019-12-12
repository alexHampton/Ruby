class WordChainer
    attr_reader :all_seen_words
    
    def initialize(dictionary_file_name = 'dictionary.txt')
        @dictionary = File.readlines(dictionary_file_name).map { |line| line.chomp }.to_set
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil}

        until @current_words.empty? || @all_seen_words.keys.include?(target)
            self.explore_current_words
        end
        build_path(target)
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |word|
            adjacent_words(word).each do |adjacent_word|
                if !@all_seen_words.keys.include?(adjacent_word)
                    new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = word
                end
            end
        end
        @current_words = new_current_words
        # new_current_words.each do |current_word|
        #     print "[#{current_word}:  #{@all_seen_words[current_word]}] "
        # end
    end

    def build_path(target)
        return [] if target == nil
        path = []
        path << target
        build_path(@all_seen_words[target]) + path
    end

    def adjacent_words(word)
        equal_length_words = @dictionary.select { |adj_word| adj_word.length == word.length } 
        adjacent_words = equal_length_words.select do |sim_word|
            sim_word.each_char.with_index.one? { |char, idx| char != word[idx] }
        end
        adjacent_words
    end

end