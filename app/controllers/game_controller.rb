require 'open-uri'
require 'json'

class GameController < ApplicationController
  def play
    # TODO: generate random grid of letters
    @rand_letter = []
    loop do
      @rand_letter << ('A'..'Z').to_a.sample
      break if @rand_letter.count.eql?(10)
    end
    @rand_letter
  end

  def score
    @world_input = params[:score].upcase.chars.sort
    @letters = params[:letters].split(' ')
    @world_input.each do |char|
      if @letters.include?(char)
        index = @letters.index(char)
        @letters.delete_at(index)
      else
        return @exist = "Sorry but #{params[:score]} can't be built out of #{@letters.join(', ')}."
      end
    end
    @url_english = "https://dictionary.lewagon.com/#{params[:score]}"
    @english_dictionnary = URI.open(@url_english).read
    @dictionary = JSON.parse(@english_dictionnary)
    if @dictionary["found"]
      return @exist = "Congratulations! #{params[:score]} is valid English word."
    else
      return @exist = "Sorry but #{params[:score]} is not a valid English word."
    end
  end
end
