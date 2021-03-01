require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    def generate_code(number)
      charset = Array('A'..'Z') + Array('a'..'z')
      Array.new(number) {charset.sample }.join
    end
    @letters = generate_code(10)
  end

  def score
    @word_two = params[:word]
    @letters = params[:letters].upcase
    # url = "https://wagon-dictionary.herokuapp.com/#{word_two}"
    # word_serialized = open(url).read
    # @word = JSON.parse(word_serialized)
    if !included?(@word_two, @letters) 
        @message = "Sorry but #{@word_two} can't be built with #{@letters}"
    elsif !english_word?(@word_two)
        @message = "Sorry but #{@word_two} is not a English word!"
    else 
        @message = "Congratulations! #{@word_two} is a English word!"
    end
  end

  def included?(word, letters)
    word.split("").all? { |letter| letters.include?(letter.upcase) }
  end
  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end
end

# class GamesController < ApplicationController
#     def new
#         @letters = (0...10).map { (65 + rand(26)).chr }.join(' ')
#       end
    
#       def score
#         @word = (params[:word] || "").upcase
#         # @included = included?(@word, @letters)
#         @english_word = english_word?(@word)
#       end
    
#       # def included?(word, letters)
#       #   word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
#       # end
    
#       def english_word?
#         response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#         json = JSON.parse(response.read)
#         json['found']
#       end
# end
