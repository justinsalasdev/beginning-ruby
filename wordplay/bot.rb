
require 'yaml'
require_relative 'wordplay'


class Bot
    attr_reader :name

    def initialize options
        @name = options[:name] || "Unnamed Bot"

        begin
            @data = YAML.load(File.read(options[:data_file]))
        rescue
            raise "Can't load bot data"
        end 
    end

    def greet
       get_random_response :greeting
    end

    def say_goodbye
        get_random_response :farewell
    end


    def respond message
        prepared_input = preprocess(message).downcase
            #preprocess 

        best_sentence = get_best_sentence(prepared_input)
        possible_responses = get_possible_responses(best_sentence)

        possible_responses[rand(possible_responses.length)]
    end


    private


    def preprocess input
        #apply presubs
        @data[:presubs].each {|presub| input.gsub(presub[0],presub[1])}
        return input
    end



    def get_random_response key
        random_index = rand(@data[:responses][key].length)
        @data[:responses][key][random_index].gsub(/\[name\]/, @name)
    end
    

  
    def get_best_sentence input
        hot_words = @data[:responses].keys.select do |key|
            key.class == String && key =~ /^w+$/
        end
        #get_sentences from extended String class
        WordPlay.choose_best_sentence(input.get_sentences, hot_words)
    end


    def get_possible_responses best_sentence
        responses = []
        @data[:responses].keys.each do |key|
             next unless key.is_a?(String)

            # For each pattern, see if the supplied sentence contains
            # a match. Remove substitutions symbols (*) before checking.
            # Push all responses to the responses array.

            if best_sentence.match('\b' + key.gsub(/\*/,'') + '\b')
                # If the pattern contains substitution placeholders,
                # perform the substitution

                if key.include?("*")
                    responses << @data[:responses][key].collect do |response|
                        #erase everything before the placeholder
                        #leaving everything after it
                        matching_selection = best_sentence.sub(/^.*#{key}\s+/,'')

                        #substitute the text after the placeholder, with
                        #the pronouns switched
                        response.sub('*',WordPlay.switch_pronouns(matching_selection))
                    end
                else 
                    #No placeholders? Just add the phrases to the array
                    responses << @data[:responses][key]
                end
            end
        end
        #If there were no matches, add the default ones
        responses << @data[:responses][:default] if responses.empty?

        #Flatten the blocks of responses to a flat array
        responses.flatten
    end
end