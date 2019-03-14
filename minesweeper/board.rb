class Board
  def initialize 
    raw_grid = Array.new(9) {Array.new(9)}
    @grid = populate(raw_grid)



  end

  def populate(grid)
    grid.map do |row|
      row.map do |square|
        rand > 0.1 ? Tile.new(false) : Tile.new(true)
      end
    end
  end

end


