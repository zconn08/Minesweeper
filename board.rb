require_relative 'tile.rb'
class Board

  attr_reader :grid



  def initialize
    @grid = Array.new(9) {Array.new(9)}
    populate_grid
    # assign_neighbors
  end

  # def assign_neighbors
  #
  #   end
  #
  #   # @grid.flatten.each do |tile|
  #   #   (0..8).each do |neighbor|
  #   #     [x + dx]
  #   #   end
  #   end
  # end

  def populate_grid
    (0..8).each do |row|
      (0..8).each do |col|
        position = [row,col]
        @grid[row][col] = Tile.new(
        self, position, [true,false,false,false,false,
          false,false,false,false].sample
          )
      end
    end
  end

  def create_tile
    Tile.new(self)
  end

  def render
    @grid.each do |row|
      row.each do |tile|
          if  tile.flagged
            print "F"
          elsif  tile.revealed
            print value_checker(tile)
          else
            print "*"
          end
      end
      puts
    end
  end

  def value_checker(tile)
    return "B" if tile.bombed?
    case tile.neighbor_bomb_count
    when 0
      "_"
    else
      tile.neighbor_bomb_count.to_s
    end
  end

end
board = Board.new
board.render
