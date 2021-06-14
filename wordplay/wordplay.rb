class WordPlay
    def self.choose_best_sentence(sentences,desired_words)
        ranked_sentences = sentences.sort_by do |sentence|
            sentence.get_words.length - (sentence.downcase.get_words - desired_words).length
        end
        ranked_sentences.last
    end

    


    def self.switch_pronouns text
        text.gsub(/\b(I am|You are|I|You|Your|My)\b/i) do |pronoun|
            case pronoun.downcase
                when "i"
                    "you"
                when "you"
                    "me"
                when "me"
                    "you"
                when "i am"
                    "you are"
                when "you are"
                    "i am"
                when "your"
                    "my"
                when "my"
                    "your"
            end
        end.sub(/^me\b/i,'i')
    end
end


class String
    def get_sentences
        gsub(/\n|\r/, ' ').split(/\.\s*/)
    end

    def get_words
        scan(/\w[\w\'\-]*/)
    end

    
end

# hot_words = %w{test ruby great}
# my_string = 'This is a test. Dull sentence here. Ruby is great. So is cake.'
# t = my_string.get_sentences.find_all do |sentence|
#     sentence.downcase.get_words.any? {|word| hot_words.include?(word)}
# end

# p t.to_a

# while input = gets
#     puts '>> ' + WordPlay.switch_pronouns(input).chomp + '?'
# end

# 5;