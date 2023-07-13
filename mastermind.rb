module ComputerSequence
  def random_sequence()
    4.times do
      @sequence.push(@colors.sample(1).join())
    end

  end
end

class Mastermind
  include ComputerSequence

  def initialize
    @sequence = []
    @colors = ["red","blue","green","yellow","orange","purple"]
  end

  def sequence
    @sequence
  end
end

computer = Mastermind.new
computer.random_sequence()
p computer.sequence

