# frozen_string_literal: true

# game
class Game
  attr_reader :board

  def initialize(board = Board.new, players = [0, 1])
    @board = board
    @players = players
  end

  def move(index)
    @board.update_tile(index, current_player)
  end

  def current_player
    @board.available_indices.count.odd? ? @players.first : @players.last
  end

  def over?
    won? || tied?
  end

  def won?
    won_by?(@players.first) || won_by?(@players.last)
  end

  def won_by?(player)
    @board.winning_indices.any? do |indices|
      indices.all? { |index| @board.grid[index] == player }
    end
  end

  def tied?
    !won? && @board.full?
  end

  def winner
    return nil unless won?

    won_by?(@players.first) ? @players.first : @players.last
  end
end