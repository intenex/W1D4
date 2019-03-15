class Board
  attr_reader :grid
  def initialize 
    raw_grid = Array.new(9) {Array.new(9)}
    @grid = populate(raw_grid)
    set_neighbor_counts
  end
  
  def set_neighbor_counts
    @grid.each do |row|
      row.each do |tile|
        tile.neighbor_bomb_count = tile.count_bombs
        tile.neighbor_positions = tile.neighbor_pos
      end
    end
  end

  def populate(grid)
    grid.map.with_index do |row, x|
      row.map.with_index do |square, y|
        rand > 0.1 ? Tile.new(false, self, [x, y]) : Tile.new(true, self, [x, y])
      end
    end
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts
    end
  end

  def flag(pos)
    row, col = pos
    tile = @grid[row][col]
    raise ArgumentError.new("That tile has been revealed") if tile.revealed
    tile.flag
  end

  def reveal(pos)
    row, col = pos
    tile = @grid[row][col]
    raise ArgumentError.new("That tile has already been revealed") if tile.revealed
    tile.reveal
  end

  def game_over?
    grid.any? {|row| row.any?{|tile| tile.revealed && tile.bomb }}
  end

  def neighbors (pos)

  end

end


