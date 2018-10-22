# frozen_string_literal: true

# game
class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @players = [:human, :computer]
  end

  def swap_players
    @players.rotate!
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

  def winning_set
    return nil unless won?

    @board.winning_indices.find do |indices|
      indices.all? { |index| @board.grid[index] == winner }
    end
  end

  def winner
    return nil unless won?

    won_by?(@players.first) ? @players.first : @players.last
  end
end
