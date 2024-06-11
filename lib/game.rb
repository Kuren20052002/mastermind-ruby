# the game?
class Game
  private

  def initialize
    @player = Player.new
  end

  def make_player_guess
    puts "Rules:\n1. 4-digit code\n2. Only numbers 1-6 are accepted"
    answer = generate_code
    until result[:black] == 4
      guess = @player.make_guess
      check_code(guess, answer)
      puts "Result: #{@result[:black]} Black, #{@result[:white]} White"
    end
  end

  def check_code(guess, answer)
    @result = { black: 0, white: 0 }
    answer_copy = answer.clone

    (0..3).each do |i|
      @result[:black] += 1 if guess[i] == answer[i]
    end

    guess.each do |number|
      if answer_copy.include?(number)
        @result[:white] += 1
        answer_copy.delete(number)
      end
    end

    @result[:white] -= @result[:black]
  end

  def generate_code
    num = []
    4.times do
      num << rand(1..6)
    end

    num
  end

  public

  def start
  end
end
