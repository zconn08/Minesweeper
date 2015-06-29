require_relative 'board'
class Minesweeper
  attr_reader :board
  def initialize
    @board = Board.new
  end

  def play_turn
    board.render
    puts "Please select a location to reveal: "
    x, y = gets.chomp.strip.split(',').map(&:to_i)
    tile = board.grid[x][y]
    tile.reveal
    return true if over?(tile)
    false
  end

  def loser?(tile)
    tile.bombed?
  end

  def over?(tile)
    loser?(tile) #|| winner?(tile)
  end

  def run
    quit = false
    until quit
      quit = play_turn
    end
    board.render
    puts "Game over. Thanks for playing"
  end

end
