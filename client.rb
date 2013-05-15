#!/usr/bin/env ruby
# encoding: utf-8

# basic client for the bot

require_relative "bot.rb"


fred = Bot.new(:name => "Fred", :data_file => "fred.bot")
charlie = Bot.new(:name => "Charlie", :data_file => "fred.bot")

r = fred.greeting

10.times do
  puts "#{fred.name}: #{r}"
  r = charlie.response_to(r)
  puts "#{charlie.name}: #{r}"
  r = fred.response_to(r)
end