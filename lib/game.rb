# This dude is the admin
class Game
  attr_reader :result

  private

  def initialize
    puts "What's your name?"
    @player = Player.new(gets.chomp)
  end

  def check_code(guess, answer) # rubocop:disable Metrics/MethodLength
    result = { black: 0, white: 0 }
    answer_copy = answer.clone

    (0..3).each do |i|
      result[:black] += 1 if guess[i] == answer[i]
    end

    return result if result[:black] == 4

    guess.each do |number|
      if answer_copy.include?(number)
        result[:white] += 1
        answer_copy.delete_at(answer_copy.index(number))
      end
    end

    result[:white] -= result[:black]
    result
  end

  def generate_code
    num = []
    4.times do
      num << rand(1..6)
    end

    num
  end

  def announce_player_result(turn, answer)
    if turn == 11
      puts "Oh no! You couldn't crack the code in time. The answer was: #{answer.join}"
    else
      puts "Congratulations #{@player.name}, you guessed the code in #{turn} turns!"
    end
  end

  def start_guessing
    puts "\nHere's how to play as the codebreaker: "
    puts "1. The code is a 4-digit number where each digit is between 1 and 6 (inclusive)."
    puts "2. You have 10 guesses to crack the code."
    puts "3. After each guess, I'll provide feedback in the form of black and white pegs."
    puts("   - Black peg: One of your digits is in the correct position AND color.")
    puts("   - White peg: One of your digits is the correct color BUT in the wrong position.")
    puts "4. Use the feedback to refine your guesses and crack the code within 10 attempts!"
    puts "\nAre you ready to begin? (yes/no)"
    gets.chomp.downcase
  end

  def start_giving
    puts "\nHere's how to play as the codemaker: "
    puts "1. Think of a secret 4-digit code using numbers from 1 to 6 (e.g., 2341)."
    puts "2. Jack, the computer, will try to guess your code within 10 tries."
    puts "3. After each guess, Jack will ask for your feedback based on the black and white peg system:"
    puts("   - Black peg: One of my digits is in the correct position AND color.")
    puts("   - White peg: One of my digits is the correct color BUT in the wrong position.")
    puts "\nRemember, be honest with your feedback! It's the key for me to crack your code."
    puts "\nAre you ready to begin? (yes/no)"
    gets.chomp.downcase
  end

  public

  def make_player_guess(answer = generate_code) # rubocop:disable Metrics/MethodLength
    unless start_guessing == "yes"
      puts "Okay, maybe next time! "
      return
    end

    result = { black: 0, white: 0 }
    turn = 0
    until result[:black] == 4 || turn > 10
      guess = @player.make_guess
      result = check_code(guess, answer)
      puts "Result: #{result[:black]} Black, #{result[:white]} White"
      turn += 1
    end

    turn -= 1 if result[:black] == 4
    announce_player_result(turn, answer)
  end

  def guess_the_code # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    unless start_giving == "yes"
      puts "Okay, maybe next time! "
      return
    end

    jack = CPU.new
    turn = 0
    code = @player.make_code

    until turn > 10
      guess = jack.make_guess(turn)

      # check the player's honesty
      result = @player.give_feedback
      until check_code(guess, code) == result
        puts "BE HONEST"
        result = @player.give_feedback
      end
      break if result[:black] == 4

      jack.eliminate_code(result)
      turn += 1
    end

    if turn == 11
      jack.be_motivated(code)
    else
      jack.be_humble(turn)
    end
  end

  def start
    puts "Welcome to Mastermind! Are you ready to be the codebreaker or codemaker today?"
    puts "1: Codebreaker"
    puts "2: Codemaker"
    loop do
      option = gets.chomp.to_i
      if option == 1
        make_player_guess
        break
      elsif option == 2
        guess_the_code
        break
      else
        puts "Please enter a valid option."
      end
    end
  end
end
