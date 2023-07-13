module Sequences
  def random_sequence() # Generates a random sequence
    4.times do # sample method picks a random color and returns an array
      @sequence.push(@colors.sample(1).join()) # join needed to make single array
    end
  end

  def choice_array(choice1, choice2, choice3, choice4) # creates a user array
    choice_sequence = [@colors[choice1-1],@colors[choice2-1],@colors[choice3-1],@colors[choice4-1]]
  end
end

module Checks
  def color_match(guess, answer)
  end

  def sequence_match(guess, answer)
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


guess = ["green", "yellow", "orange", "purple"]
answer = ["red", "green", "orange", "blue"]
