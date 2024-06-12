# the game?
class Game
  attr_reader :result

  private

  def initialize
    @player = Player.new
    @result = { black: 0, white: 0 }
  end

  def check_code(guess, answer)
    @result = { black: 0, white: 0 }
    answer_copy = answer.clone

    (0..3).each do |i|
      @result[:black] += 1 if guess[i] == answer[i]
    end

    return if @result[:black] == 4

    guess.each do |number|
      if answer_copy.include?(number)
        @result[:white] += 1
        answer_copy.delete_at(answer_copy.index(number))
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

  def announce_result(turn, answer)
    if turn == 11
      puts "Oh no! You couldn't crack the code in time. The answer was: #{answer.join}"
    else
      puts "Congratulations #{@player.name}, you guessed the code in #{turn} turns!"
    end
  end

  public

  def make_player_guess(answer = generate_code)
    puts "Rules:\n1. 4-digit code\n2. Only numbers 1-6 are accepted"
    puts "Tries to guess the code in 10 guesses"

    turn = 0
    until @result[:black] == 4 || turn > 10
      guess = @player.make_guess
      check_code(guess, answer)
      puts "Result: #{@result[:black]} Black, #{@result[:white]} White"
      turn += 1
    end

    announce_result(turn, answer)
  end

  def start
  end
end
