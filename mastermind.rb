module Sequences # sequence generators
  def random_sequence() # Generates a random sequence
    4.times do # sample method in next linepicks a random color and returns an array
      @sequence.push(@colors.sample(1).join()) # join needed to make single array
    end
    @sequence # updates @sequence; will use for code breaker play or random code maker
  end

  def user_sequence(choice1, choice2, choice3, choice4) # array from user choice
    choice_sequence = [@colors[choice1-1],@colors[choice2-1],@colors[choice3-1],@colors[choice4-1]]
  end

end

module Checks # tests for player turns
  def color_match_test(guess, answer) # arguments are arrays
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

  def sequence_match_test(guess, answer) # arguments are arrays
    count = 0
    guess.each_with_index do |color, index| # iterate over all guesses
      count += 1 if color == answer[index] # increment if guess & answer match at index
    end
    @matching_sequence = count # update sequence matches; need for game_over_status
  end

end

module GameOver # game ending conditions
  def game_over_status()
    if @matching_sequence == 4 #checks to see if all terms match
      puts "You are da winner!"
      @game_over = true # updates game_over status
    end

    if @guess_counter == 10 && @matching_sequence != 4 # 10 guesses and <4 matches
      puts "FAILURE! TOO MANY GUESSES!"
      @game_over = true # updates game_over status
    end
  end

end

module Information # stores information to be displayed in the terminal
  def introduction() # used at the start of the program
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

  def select_role() # used when determining to play as code maker or code breaker
    user_choice = nil # user_choice will be rewritten based on user input
    valid_entry = false # valid_entry is false until user inputs 1 or 2

    until valid_entry # loop until valid_entry is changed to true
      puts "Enter 1 to be the code breaker or enter 2 to be the code maker"
      user_choice = gets.chomp.to_i # changes input to integer

      if user_choice == 1
        puts "You have selected to be the code breaker!"
        puts
        @role = "code breaker" # update @role
        valid_entry = true # needed to exit unil loop
      elsif user_choice == 2
        puts "You have selected to be the code maker!"
        puts
        @role = "code maker" # update @role
        valid_entry = true # needed to exit unil loop
      else
        puts "Invalid entry. Try again." # returns to top of the loop
        puts
      end
    end
  end

  def colors_information() # prints information about available colors and selection
    puts "The colors are #{@colors[0]}, #{@colors[1]}, #{@colors[2]}, #{@colors[3]}, #{@colors[4]}, and #{@colors[5]}."
    puts "1 - #{@colors[0]}      2 - #{@colors[1]}"
    puts "3 - #{@colors[2]}      4 - #{@colors[3]}"
    puts "5 - #{@colors[4]}      6 - #{@colors[5]}"
    puts "Enter your sequence as a 4 digit number. For example, for the sequence "
    puts "\'#{@colors[1]}, #{@colors[2]}, #{@colors[5]}, #{@colors[1]}\', then your entry would be \'2362\'."
  end
end

module GamePlay
  def code_breaker_turn()
    @guess_counter += 1 # adds to @guess_counter when method executes
    valid_entry = false # needed for loop
    entry = nil # will be overwritten by user input

    until valid_entry # loop until a valid entry is provided
      puts
      puts "This is guess number #{@guess_counter}. Enter your sequence."
      entry = gets.chomp # user input

      if entry.match?(/\A[1-6]{4}\z/) #regex match for 4 digits between 1 and 6
        valid_entry = true # updates to true to exit loop
      else
        puts "Invalid entry. Try again." # return to the top of the loop
      end
    end
    # chars method turns entry string into array. The map method turns each item in
    # the array into an integer. & is a shorthand for when there are no arguments.
    # The result is that each element of entry.chars will be returned as an integer.
    entry.chars.map(&:to_i) # returns the array. Description in comment above.
  end

  def code_maker_turn()
    valid_entry = false
    entry = nil

    until valid_entry
      puts "Enter your sequence."
      entry = gets.chomp

      if entry.match?(/\A[1-6]{4}\z/)
        valid_entry = true
      else
        puts "Invalid entry. Try again."
      end
    end
    entry.chars.map(&:to_i)
  end

end

class Mastermind
  include Sequences, Checks, GameOver, Information, GamePlay
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

def play_game() # main game loop
  game = Mastermind.new
  game.introduction # calls introduction method from Information
  game.select_role # select_role is a role creation method and determines gameplay

  # There are two gameplay styles based on the outcome of select_role
  if game.role == "code breaker" # GAMEPLAY OPTION 1
    computer_sequence = game.random_sequence # creates a random sequence to guess

    until game.game_over # remain in this loop until game_over is set to true
      game.colors_information # prints information about the colors
      choice_array = game.code_breaker_turn # creates array from user input
      guess = game.user_sequence(choice_array[0],choice_array[1],choice_array[2],choice_array[3])

      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Your guess is: #{guess.join("  ")}"
      puts

      game.color_match_test(guess, computer_sequence) # checks for color matches
      game.sequence_match_test(guess, computer_sequence) # checks for correct terms

      puts "There are #{game.matching_colors} matching colors and #{game.matching_sequence} correct sequence guesses."
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

      game.game_over_status # sets game.game_over = true if 10 moves or correct answer
      if game.game_over == true
        puts "The sequence was: #{computer_sequence.join("  ")}" # prints computer sequence
      end
    end

  elsif game.role == "code maker" # GAMEPLAY OPTION 2
    # Player Input Here
    game.colors_information
    choice_array = game.code_maker_turn
    codemaker_array = game.user_sequence(choice_array[0],choice_array[1],choice_array[2],choice_array[3])
    puts "Your sequence is: #{codemaker_array.join("  ")}"

    #Computer Player From Here to game over

  end

end


play_game()


