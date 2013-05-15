#!/usr/bin/env ruby
# encoding: utf-8

# implementation of the WordPlay bot from Ch. 12 of Peter Cooper's *Beginning Ruby*



class WordPlay
  def WordPlay.best_sentence(sentences, desired_words)
    # "best" at the moment means "most desired words"
    ranked_sentences = sentences.sort_by do |e|
      e.words.length - (e.downcase.words - desired_words).length
    end
    
    ranked_sentences.last
  end
  
  def WordPlay.switch_pronouns(text)
    s = text.gsub(/\b(I am|You are|I|You|me|Your|My)\b/i) do |pronoun|
      case pronoun.downcase
      when "i"
        "you"
      when "you"
        "me"
      when "i am"
        "you are"
      when "you are"
        "I am"
      when "your"
        "my"
      when "my"
        "your"
      when "me"
        "you"
      end
    end
    
    s.gsub(/^me\b/i, "i")
  end
end


# extend the String class with a method to return separated sentences
class String
  def sentences
    gsub(/\n|\r/, "").split(/\.\s*/)
  end
  
  def words
    w = scan(/\w[\w\'\-]*/)
  end
end