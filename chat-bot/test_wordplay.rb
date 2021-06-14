require 'minitest/autorun' #loads String class
require_relative 'wordplay'

class TestWordPlay < Minitest::Test
    def test_sentences
        assert_equal(["a","b","c d","e f g"],"a. b. c d. e f g.".get_sentences)#from String class from wordplay
        test_text = %q{Hello. This is a test of sentence separation.This is the end of the test.}

        assert_equal("This is the end of the test", test_text.get_sentences[2])
    end


    def test_words
        assert_equal(%w{this is a test}, "this is a test".get_words)
        assert_equal(%w{these are mostly words}, "these are, mostly, words".get_words)
    end

    def test_sentence_choice
        assert_equal('This is a great test',
            WordPlay.choose_best_sentence(['This is a test',
            'This is another test',
            'This is a great test'],
            %w{test great this}))


        assert_equal('This is a great test',
            WordPlay.choose_best_sentence(['This is a great test'],
            %w{still the best}))
    end

    def test_basic_pronouns
        assert_equal("i am a robot", WordPlay.switch_pronouns("you are a robot"))
        assert_equal("you are a person", WordPlay.switch_pronouns("i am a
        person"))
        assert_equal("i love you", WordPlay.switch_pronouns("you love me"))
    end

    def test_mixed_pronouns
        assert_equal("you gave me life", WordPlay.switch_pronouns("i gave you life"))
        assert_equal("i am not what you are", WordPlay.switch_pronouns("you are
        not what i am"))
        assert_equal("i annoy your dog", WordPlay.switch_pronouns("you annoy my dog"))
    end
end