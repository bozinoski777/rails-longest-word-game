require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    randlett = ('a'..'z').to_a.sample(1000) * 100
    @letters = randlett.sample(10)
  end

  def eng_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionary_data = open(url).read
    dictionary = JSON.parse(dictionary_data)
    dictionary['found']
  end

  def score
    @user_input = params[:user_input]
    @random_letters = params[:random_letters].delete(' ')
    user_input_chars = @user_input.chars
    random_letters_chars = @random_letters.chars
    if (user_input_chars - random_letters_chars).empty?
      eng_word?(@user_input) ? @output = "\"#{@user_input}'\" is a valid English word!" : @output = "Sorry, #{@user_input} is not an english word"
    else
      @output = "Sorry but \"#{@user_input}\" can't be built from \"#{random_letters_chars.join(' | ').upcase}\""
    end
  end
end
