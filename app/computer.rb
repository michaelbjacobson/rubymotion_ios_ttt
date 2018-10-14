# frozen_string_literal: true

# Computer
class Computer
  def self.choose_move(game)
    return opening_gambit(game) if game.board.empty?

    negamax(game, 0, {})
  end

  def self.opening_gambit(game)
    game.board.corners.sample
  end

  def self.heuristic_value(game)
    game.won? ? -1 : 0
  end

  def self.best_move(scores_hash)
    sorted = scores_hash.sort_by { |_move, score| score }
    sorted.last.first
  end

  def self.best_score(scores_hash)
    sorted = scores_hash.sort_by { |_move, score| score }
    sorted.last.last
  end

  def self.negamax(game, depth, scores_hash)
    return heuristic_value(game) if game.over?

    game.board.available_indices.each do |index|
      game.board.update_tile(index, game.current_player)
      scores_hash[index] = (-1 * negamax(game, (depth + 1), {}))
      game.board.reset_tile(index)
    end

    depth.zero? ? best_move(scores_hash) : best_score(scores_hash)
  end

  private_class_method :opening_gambit, :negamax, :heuristic_value, :best_move, :best_score
end
