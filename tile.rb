class Tile
  PERMUTATIONS = [-1,1,0].repeated_permutation(2).to_a.reject{ |el| el == [0,0] }
  attr_reader :bombed, :flagged, :revealed
  def initialize(board, position, bombed = false)
    @board = board
    @bombed = bombed
    @flagged = false
    @revealed = false
    @position = position
  end
  def self.change_flag
    @flagged ? @flagged = false : @flagged = true
  end
  def bombed?
    @bombed
  end
  def reveal
    @revealed = true
  end
  def neighbors
    neighbors = []
    PERMUTATIONS.each do |permutation|
      dx = permutation[0]
      dy = permutation[1]
      [5,5]
      row, col = @position
      proposed_x = row + dx
      proposed_y = col + dy
      neighbors << [proposed_x, proposed_y] if ((0..8).include?(proposed_x) && (0..8).include?(proposed_y))
    end
    neighbors
  end
  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each do |neighbor|
        row, col = neighbor
        bomb_count += 1 if @board.grid[row][col].bombed
    end
    bomb_count
  end
  def inspect
    "bombed: #{self.bombed} \n
    flagged: #{self.flagged} \n
    revealed: #{self.revealed} \n"
  end
end
