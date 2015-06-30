require_relative 'board'
require 'yaml'
class Minesweeper
  attr_reader :board
  attr_accessor :result, :quit

  def initialize
    @board = Board.new
  end

  def play_turn

    puts "Please select a location: "
    x, y = gets.chomp.strip.split(',').map(&:to_i)
    tile = board.grid[x][y]

    input = nil
    until input == "f" || input == "r"
      puts "Flag (f) or reveal (r)?"
      input = gets.chomp.downcase.strip
    end
    input == "f" ? tile.change_flag : tile.reveal

  end

  def loser?
    loser = board.grid.flatten.any? do |tile|
      tile.bombed? && tile.revealed?
    end
    if loser
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
      self.result = 'winner'
      true
    else
      false
    end
  end

  def over?
    loser? || winner?
  end

  def run
    board.render
    until over?
      play_turn
      board.render
      break if save_and_quit?
    end
    @board.grid.flatten.each {|tile| tile.reveal}
    if self.result == 'loser'
      puts "Game over. Thanks for playing"
    elsif self.result == 'winner'
      puts "Congratulations! You win!!!"
    end
  end

  def save_and_quit?
    puts "Would you like to save and quit('y')?"
    input = gets.chomp.downcase.strip
    if input == "y"
      File.open("saved_game", 'w') do |file|
        file.puts self.board.to_yaml
      end
      true
    else
      false
    end
  end

end

new_game = Minesweeper.new
new_game.run
