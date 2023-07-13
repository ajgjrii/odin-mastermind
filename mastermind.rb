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
  def color_match(guess, answer)
    color_matches = [] # will store any matched colors
    computer = answer.dup # needed so as to not overwrite answer array

    guess.each do |item| # iterate over guess
      if computer.include?(item) # finds match in answer array
        computer.delete_at(computer.index(item)) # delete from answer array
        color_matches.push(item) # add item to color match
      end
    end
    color_matches.length # returns number of matched colors
  end

  def sequence_match(guess, answer)
    count = 0
    guess.each_with_index do |color, index|
      count += 1 if color == answer[index]
    end
    count
  end

end

class Mastermind
  include Sequences, Checks

  def initialize
    @sequence = []
    @colors = ["red","blue","green","yellow","orange","purple"]
  end

  def sequence
    @sequence
  end
end





game = Mastermind.new
p my_guess = game.user_guess(2,3,4,5)
p comp_sequence = game.random_sequence()
p colors_correct = game.color_match( my_guess, comp_sequence)
p my_guess
p comp_sequence
p correct_matches = game.sequence_match(my_guess, comp_sequence)
