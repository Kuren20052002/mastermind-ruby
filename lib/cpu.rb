require_relative "player"

# This dude guesses your code
class CPU < Player
  attr_reader :name

  DIALOGUE = ["Interesting... the black and white pegs tell a fascinating story. Let me see if I can decipher it",
              "No worries, this code is practically begging to be cracked!\nJust a few more calculations and I'll have it figured out",
              "Hmm, the feedback suggests a trickier code than I anticipated.\nBut hey, that just makes it more fun to unravel!",
              "Let's approach this strategically.\nBased on the clues, eliminating some possibilities might be the key here",
              "This code is putting my logic skills to the test!\nBut don't worry, I thrive on a good challenge",
              "Hmm, this code is playing coy, but I'm not one to give up easily.\nLet's see if we can tickle it into revealing its secrets",
              "Like a detective examining clues.\nI'm carefully analyzing the black and white pegs to uncover the code's hidden structure",
              "This code is like a formidable opponent, but I'm determined to outsmart it.\nEvery guess brings us closer to victory!"].freeze

  private

  def think
    puts "#{DIALOGUE.sample}...\n"
    sleep 1
  end

  def initialize
    super("Jack")
    @all_codes = fetch_all_combinations
  end

  def fetch_all_combinations
    (1..6).to_a.repeated_permutation(4).to_a
  end

  def check_code(guess, answer) # rubocop:disable Metrics/MethodLength
    result = { black: 0, white: 0 }
    answer_copy = answer.clone

    (0..3).each do |i|
      result[:black] += 1 if guess[i] == answer[i]
    end

    return if result[:black] == 4

    guess.each do |number|
      if answer_copy.include?(number)
        result[:white] += 1
        answer_copy.delete_at(answer_copy.index(number))
      end
    end

    result[:white] -= result[:black]
    result
  end

  public

  def make_guess(turn)
    if turn.zero?
      puts "\nFor the first guess, I'm feeling a bit... predictable. But hey, 1122 has served me well in the past!"
      @guess = [1, 1, 2, 2]
    else
      think
      @guess = @all_codes.sample
      puts "Is the code #{@guess.join}"
    end
    @all_codes.delete(@guess)
    @guess
  end

  def eliminate_code(feedback)
    @all_codes.filter! do |code|
      check_code(@guess, code) == feedback
    end
  end

  def be_humble(turn)
    puts "And there you have it!\nAnother code conquered in #{turn + 1} turns, thanks to your clever code-creation skills and my unwavering determination."
  end

  def be_motivated(answer)
    puts "Damn, the code is #{answer.join} huh.\nWell, that code proved to be a formidable foe.\nBut don't worry, I'll learn from this and come back even stronger for the next challenge."
  end
end
