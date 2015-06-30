require 'byebug'

class Tile
  RELATIVE_POSITIONS = [-1,-1,0,1,1].permutation(2).to_a.uniq
  attr_reader :bombed, :flagged, :revealed, :board

  def initialize(board, position, bombed = false)
    @board = board
    @bombed = bombed
    @flagged = false
    @revealed = false
    @position = position
  end

  def change_flag
    @flagged = !@flagged
  end

  def bombed?
    @bombed
  end

  def reveal
    return if @revealed
    @revealed = true
    neighbors.each(&:reveal) if neighbor_bomb_count.zero?
  end

  def revealed?
    @revealed
  end

  def neighbors
    neighbors_list = []
    RELATIVE_POSITIONS.each do |offset|
      position = [
        offset.first + @position.first,
        offset.last + @position.last
      ]
      neighbors_list << board[position] if board.onboard?(position)
    end
    neighbors_list
  end

  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.bombed?
    end
    bomb_count
  end

  def inspect
    "bombed: #{self.bombed} flagged: #{self.flagged} revealed: #{self.revealed}"
  end

  def to_s
    if revealed
      return "B" if self.bombed?
      bomb_count = self.neighbor_bomb_count
      bomb_count.zero? ? "_" : bomb_count
    else
      flagged ? "F" : "*"
    end
  end
end
