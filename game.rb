require_relative 'board'
class Minesweeper
  attr_reader :board
  def initialize
    @board = Board.new
  end

  def play_turn
    puts "Please select a location to reveal: "
    x, y = gets.chomp.strip.split(',').map(&:to_i)
    tile = board.grid[x][y]
    p tile
  end

  def loser?

  end

  def run
  end

end
