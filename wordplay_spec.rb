require "rspec"
require_relative "wordplay.rb"



describe "String\#sentences sentence parsing functionality" do
  it "parses simple string into sentences" do
    s = "This is a sentence. And another. And yet another."
    s.sentences.should == ["This is a sentence", "And another", "And yet another"]
  end
  
  it "parses multiline string into sentences" do
    s = %q{Hello. This is a test of
basic sentence splitting. It
even works over multiple lines}
    s.sentences.should == ["Hello", "This is a test of basic sentence splitting", "It even works over multiple lines"]
  end
end

describe "String word parsing functionality" do
  it "parses words in a straightforward sentence" do
    s = "This is a very simple sentence"
    s.words.should == ["This", "is", "a", "very", "simple", "sentence"]
  end
  
  it "parses words that have apostrophes" do
    s = "I'm on my way to Ethan's house where they're eating"
    s.words.should == ["I'm", "on", "my", "way", "to", "Ethan's", "house", "where", "they're", "eating"]
  end
end

describe "class method WordPlay\#best_sentence sentence matching" do
  it "selects correct sentence" do
    sentences = ["This is a test", "This is another test", "This is a great test"]
    words = %w{test great this}
    WordPlay.best_sentence(sentences, words).should == "This is a great test"
  end
  
  it "returns sentence when only one passed in and no matches" do
    sentences = ["This is a great test"]
    words = %w{still the best}
    WordPlay.best_sentence(sentences, words).should == "This is a great test"
  end
end

describe "class method WordPlay\#switch_pronouns correctly switches pronouns" do
  it "switches simple pronouns" do
    s = "Your cat is fighting with my cat"
    WordPlay.switch_pronouns(s).should == "My cat is fighting with your cat"
  end
  
  it "switches second person to first person nominative and accusative" do
    s = "You are my robot"
    WordPlay.switch_pronouns(s).should == "I am your robot"
    s = "My cat is fighting with you"
    WordPlay.switch_pronouns(s).should == "Your cat is fighting with me"
  end
end


