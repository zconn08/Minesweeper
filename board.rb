require_relative 'tile.rb'
class Board

  attr_reader :grid, :size
  BOMB_SCARCITY = 8

  def initialize
    @size = 9
    @grid = Array.new(size) {Array.new(size)}
    populate_grid
  end

  def populate_grid
    (0...size).each do |row|
      (0...size).each do |col|
        position = [row,col]
        @grid[row][col] = create_tile(position)
      end
    end
  end

  def create_tile(position)
    Tile.new(self, position, weighted_random_boolean(BOMB_SCARCITY))
  end

  def weighted_random_boolean(num)
    rand(num) == 0 ? true : false
  end

  def render
    puts
    print " "
    size.times { |index| print index }
    puts
    @grid.each_with_index do |row, index|
      print index
      row.each do |tile|
        print tile.to_s
      end
      puts
    end
  end

  def [](pos)
    grid[pos.first][pos.last]
  end

  def onboard?(pos)
    pos.all? { |coord| coord.between?(0, size - 1) }
  end
end
