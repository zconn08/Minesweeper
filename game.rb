require_relative 'board'
class Minesweeper
  attr_reader :board
  attr_accessor :result

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
    if tile.bombed?
      self.result = 'loser'
      true
    else
      false
    end
  end

  def winner?
    winner = board.grid.flatten.all? do |tile|
      tile.bombed? || tile.revealed?
    end
    if winner
      @result = 'winner'
      true
    else
      false
    end
  end

  def over?(tile)
    loser?(tile) || winner?
  end

  def run
    quit = false
    until quit
      quit = play_turn
    end
    @board.grid.flatten.each {|tile| tile.reveal}
    board.render
    if @result == 'loser'
      puts "Game over. Thanks for playing"
    else
      puts "Congratulations! You win!!!"
    end
  end

end

new_game = Minesweeper.new
new_game.run
