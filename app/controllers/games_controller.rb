require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    # pass each letter as string
    grid_letters = @grid.each_char { |letter| print letter, '' }
    if !letter_in_grid
      @result = "Sorry, #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word(@answer)
      @result = "Sorry, #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word(@answer)
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else letter_in_grid && !english_word(@answer)
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end

  private

  def letter_in_grid
    @answer.upcase.chars.all? { |letter| @grid.include?(letter) }
  end

  def english_word(keyword)
    url = "https://wagon-dictionary.herokuapp.com/#{keyword}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end
end
