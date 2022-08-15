require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters = @letters.join split = ' '
  end


  def score
    @word = params[:word]
    @letters = params[:letters]
    @letters = @letters.join('') if @letters.class == Array

    if english_word?(@word)
      score = compute_score(@word)
      [score, "well done"]
    else
      [0, "not an english word"]
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
    end
  end
end
