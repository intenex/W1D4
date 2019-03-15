require_relative "tile.rb"
require_relative "board"

class Minesweeper
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    play_turn until game_over?
  end

  def play_turn
    system('clear')
    @board.render
    puts "Enter position to guess: (x,y)"
    pos = gets.chomp.split(",").map(&:to_i)
    begin
      if valid_pos?(pos)
        flag_or_reveal(pos)
      else
        puts "Put a valid pos"
        play_turn
      end
    rescue => e 
      puts e 
      retry 
    end
  end

  def flag_or_reveal(pos)
    puts "[F]lag or [R]eveal?"
    action = gets.chomp.downcase
    case action 
    when "f" 
        board.flag(pos)
    when "r" 
        board.reveal(pos)
    else
        puts "invalid input"
        flag_or_reveal(pos)
    end
  end

  def valid_pos?(pos)
    x, y = pos
    x && y && in_bounds?(x) && in_bounds?(y)
  end

  def in_bounds?(value)
    value >= 0 && value < 9
  end

  def game_over?
    puts "BOOM!!!!"
    @board.game_over?
  end

end