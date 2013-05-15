#!/usr/bin/env ruby
# encoding: utf-8

require_relative "wordplay.rb"
require "yaml"


class Bot
  attr_reader :name
  
  def initialize(options)
    @name = options[:name]  || "Unnamed Bot"
    begin
      @data = YAML.load(File.read(options[:data_file]))
    rescue
      raise "Can't load bot data"
    end
  end
  
  def greeting
    random_response(:greeting)
  end
  
  def farewell
    random_response(:farewell)
  end
  
  def response_to(input)
    prepared_input = preprocess(input.downcase)
    sentence = best_sentence(prepared_input)
    responses = possible_responses(sentence)
    
    # return a random response
    responses[rand(responses.length)]
  end
  
  
  def save_data
    puts "this will save the data"
  end
  
  
  
  private
  def random_response(key)
    random_index = rand(@data[:responses][key].length)
    @data[:responses][key][random_index].gsub(/\[name\]/, @name)
  end
  
  private
  def preprocess(input)
    perform_substitutions(input)
  end
  
  private
  def perform_substitutions(input)
    @data[:presubs].each { |s| input.gsub!(s[0], s[1]) }
    input
  end
  
  private
  def best_sentence(input)
    input.sentences.first
  end
  
  private
  def possible_responses(sentence)
    responses = []
    
    # find all patterns to try to match against
    @data[:responses].keys.each do |pattern|
      next unless pattern.is_a?(String)
      
      #for each pattern, see if the supplied sentence contains
      # a match. remove substitution symbols (*) before checking.
      # push all responses to the responses array.
      re = '\b' + pattern.gsub(/\*/, "") + '\b'
      if sentence.match(re)
        # if the pattern contains substitution placeholders,
        # perform the subs
        if pattern.include?('*')
          responses << @data[:responses][pattern].collect do |phrase|
            # first, erase everything before the placeholder
            # leaving everything after it
            matching_section = sentence.sub(/^.*#{pattern}\s+/, '')
            
            # then substitute the text after the placeholder, with
            # the pronouns switched
            phrase.sub('*', WordPlay.switch_pronouns(matching_section))
          end
        else
          # no placeholders? just add the phrases to the array
          responses << @data[:responses][pattern]
        end
      end
    end
    
    # if there were no matches, add the default ones
    responses << @data[:responses][:default] if responses.empty?
    
    # flatten the blocks of responses to a flat array
    responses.flatten
  end
end
