require 'byebug'

class Tile
  attr_reader :bomb, :pos
  attr_accessor :revealed, :flagged, :neighbor_bomb_count, :neighbor_positions
  def initialize(bomb, board, pos)
    @bomb = bomb
    @revealed = false
    @flagged = false
    @board = board
    @pos = pos
    @neighbor_bomb_count = nil
    @neighbor_positions = nil
  end

  def neighbor_pos
    x, y = @pos
    northwest = [x-1, y-1]
    north = [x-1, y]
    northeast = [x-1, y+1]
    east = [x, y+1]
    southeast = [x+1, y+1]
    south = [x+1, y]
    southwest = [x+1, y-1]
    west = [x, y-1]
    all_pos = [northwest, north, northeast, east, southeast, south, southwest, west]
    
    all_pos.select { |pos| in_bounds?(pos)}
  end

  def is_bomb?(pos)
    x, y = pos
    @board.grid[x][y].bomb
  end

  def in_bounds?(pos)
    x, y = pos
    x >= 0 && x < 9 && y >= 0 && y < 9
  end

  def count_bombs
   neighbor_pos.select {|pos| is_bomb?(pos) }.length

  end

  def reveal
    return if @revealed
    @revealed = true
    if neighbor_bomb_count == 0
      @neighbor_positions.each do |pos|
        x, y = pos
        @board.grid[x][y].reveal
      end
    end
  end

  def flag
    @flagged = !@flagged
  end

  def to_s
    if flagged
      :F
    elsif revealed
      bomb ? :B : :"#{@neighbor_bomb_count}"
    else
       :*
    end
  end
end