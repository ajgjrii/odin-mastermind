module Sequences
  def random_sequence() # Generates a random sequence
    4.times do # sample method picks a random color and returns an array
      @sequence.push(@colors.sample(1).join()) # join needed to make single array
    end
    @sequence
  end

  def user_sequence(choice1, choice2, choice3, choice4) # creates a user array
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
  def game_over_status()
    if @matching_sequence == 4
      puts "You are da winner!"
      @game_over = true
    end

    if @guess_counter == 10 || @matching_sequence != 4
      puts "FAILURE! TOO MANY GUESSES!"
      @game_over = true
    end
  end

end

module Information
  def introduction()
    puts "Let\'s play Mastermind! The rules are simple: guess the sequence!"
    puts
    puts "The code maker creates a sequence of 4 colors from a selection of 6 colors."
    puts "The sequence can contain repeats if the code maker chooses to do so, as long"
    puts "as the sequence contains 4 colors."
    puts
    puts "The code breaker is tasked with figuring out the sequence within 10 guesses."
    puts "After each guess, the code breaker will be told how many of the terms are"
    puts "correct, and how many colors, regardless of order, are correct."
    puts
  end

  def select_role()
    user_choice = nil
    valid_entry = false

    until valid_entry
      puts "Enter 1 to be the code breaker or enter 2 to be the code maker"
      user_choice = gets.chomp.to_i

      if user_choice == 1
        puts "You have selected to be the code breaker!"
        puts
        @role = "code breaker"
        valid_entry = true
      elsif user_choice == 2
        puts "You have selected to be the code maker!"
        puts
        @role = "code maker"
        valid_entry = true
      else
        puts "Invalid entry. Try again."
      end
    end
    user_choice
  end

  def colors_information()
    puts "The colors are #{@colors[0]}, #{@colors[1]}, #{@colors[2]}, #{@colors[3]}, #{@colors[4]}, and #{@colors[5]}."
  end
end

module CodeBreaker
  def code_breaker_turn()
  end

end

class Mastermind
  include Sequences, Checks, GameOver, Information, CodeBreaker
  attr_accessor :matching_colors, :matching_sequence, :game_over, :role
  attr_reader :sequence

  def initialize
    @sequence = []
    @guess_counter = 0
    @game_over = false
    @matching_colors = 0
    @matching_sequence = 0
    @role = nil
    @colors = ["red","blue","green","yellow","orange","purple"]
  end

  def guess()
    @guess_counter += 1
  end

end

def play_game()
  game = Mastermind.new
  game.introduction # calls introduction method from Information
  game.select_role # select_role is a role creation method and determines gameplay

  if game.role == "code breaker"
    computer_sequence = game.random_sequence # creates a random sequence to guess
    game.colors_information
  #elsif @role == "code maker" # NEED TO ADD THIS PLAY STYLE LATER
  end

  p computer_sequence # DELETE ME, USE FOR DEBUGGING


end


play_game()


