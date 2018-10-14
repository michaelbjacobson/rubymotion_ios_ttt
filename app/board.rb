# frozen_string_literal: true

# Board
class Board
  attr_reader :grid, :winning_indices

  def initialize(grid = Array.new(9, nil))
    @grid = grid
    @winning_indices = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  def update_tile(index, player)
    return false unless @grid[index].nil?

    @grid[index] = player
  end

  def reset_tile(index)
    @grid[index] = nil
  end

  def available_indices
    (0..8).select { |i| @grid[i].nil? }
  end

  def reset
    @grid = Array.new(9, nil)
  end

  def full?
    available_indices.length.zero?
  end

  def empty?
    available_indices.length == 9
  end

  def corners
    [0, 2, 6, 8]
  end
end
