module Sequences
  def random_sequence() # Generates a random sequence
    4.times do # sample method picks a random color and returns an array
      @sequence.push(@colors.sample(1).join()) # join needed to make single array
    end
    @sequence
  end

  def user_guess(choice1, choice2, choice3, choice4) # creates a user array
    choice_sequence = [@colors[choice1-1],@colors[choice2-1],@colors[choice3-1],@colors[choice4-1]]
  end
end

module Checks
  def color_match_test(guess, answer)
    color_matches = [] # will store any matched colors
    computer = answer.dup # needed so as to not overwrite answer array

    guess.each do |item| # iterate over guess
      if computer.include?(item) # finds match in answer array
        computer.delete_at(computer.index(item)) # delete from answer array
        color_matches.push(item) # add item to color match
      end
    end
    @matching_colors = color_matches.length # returns number of matched colors
  end

  def sequence_match_test(guess, answer)
    count = 0
    guess.each_with_index do |color, index|
      count += 1 if color == answer[index]
    end
    @matching_sequence = count
  end

end

module GameOver # NEED TO TEST THIS OUT WITH GAME LOOP
  def win_check()
    if @colors_matched == 4 && @sequence_matched == 4
      puts "You are da winner!"
    end
  end
end


class Mastermind
  include Sequences, Checks, GameOver
  attr_accessor :sequence, :matching_colors, :matching_sequence

  def initialize
    @sequence = []
    @matching_colors = 0
    @matching_sequence = 0
    @colors = ["red","blue","green","yellow","orange","purple"]
  end


end






