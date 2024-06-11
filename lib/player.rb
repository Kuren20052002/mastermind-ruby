# OMG ITS THE PLAYERRR
class Player
  def initialize(name)
    @name = name
  end

  def make_guess
    puts "Take a guess: \n"
    loop do
      loop = gets.chomp.split.map!(&:to_i)

      return loop if @loop.all? { |number| (1..6).include?(number) }

      puts "Look at the rules again dummy"
    end
  end
end
