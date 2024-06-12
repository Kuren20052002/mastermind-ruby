# OMG ITS THE PLAYERRR
class Player
  attr_reader :name

  def initialize
    @name = whats_my_name
  end

  def whats_my_name
    puts "Whats your name?"
    name = gets.chomp
    return "Player 1" if name.empty?

    name
  end

  def make_guess
    puts "Take a guess: \n"
    loop do
      loop = gets.chomp.chars.map!(&:to_i)
      return loop if loop.all? { |number| (1..6).include?(number) } && loop.length == 4

      puts "Look at the rules again dummy"
    end
  end
end
