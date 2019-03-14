class Minesweeper
  def initialize
    @board = Board.new

  end

  def play
    play_turn until game_over?
  end

  def play_turn
    puts "Enter position to guess: (x,y)"
    pos = gets.chomp.split(",").map(&:to_i)
    if valid_pos?(pos)
      
    else
      puts "Put a valid pos"
      play_turn
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
    @board.game_over?
  end

end