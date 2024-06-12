# OMG ITS THE PLAYERRR
class Player
  attr_reader :name

  private

  def initialize(name = "Player 1")
    @name = name
  end

  def code_valid?(code)
    code.all? { |number| (1..6).include?(number) } && code.length == 4
  end

  public

  def make_guess
    puts "Take a guess: \n"
    loop do
      loop = gets.chomp.chars.map!(&:to_i)
      return loop if code_valid?(loop)

      puts "Look at the rules again dummy"
    end
  end

  def make_code
    puts "\nCome up with a secret 4-digit code using numbers 1 to 6"
    puts "I'll use this information to check your honesty, Jack won't see it so don't worry ;)"

    loop do
      loop = gets.chomp.chars.map!(&:to_i)
      return loop if code_valid?(loop)

      puts "Look at the rules again dummy"
    end
  end

  def give_feedback
    result = {}
    puts "\nGive your feedback: "
    print "Black pegs: "
    result[:black] = gets.chomp.to_i
    print "White pegs: "
    result[:white] = gets.chomp.to_i
    puts "\n"
    result
  end
end
