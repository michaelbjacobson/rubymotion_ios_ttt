# frozen_string_literal: true

# MainScreen
class GameScreen < PM::Screen
  attr_accessor :first_player

  stylesheet GameScreenStylesheet

  def on_load
    init_views
    new_game
    init_touch_listeners
  end

  private

  def init_touch_listeners
    find(@square_views).on(:tap) do |square|
      break if @game.over?
      break unless @game.current_player == :human

      index = find(square).tags[:index]
      break unless @game.board.grid[index].nil?

      @game.move(index) unless index.nil?
      update_views
      if @game.over?
        game_over
        break
      end

      app.after 1 do
        index = Computer.choose_move(@game)
        @game.move(index) unless index.nil?
        update_views
        game_over if @game.over?
      end
    end
  end

  def new_game
    @game = Game.new
    if first_player == :computer
      @game.swap_players
      index = Computer.choose_move(@game)
      @game.move(index) unless index.nil?
    end
    update_views
    find(@second_prompt).hide
  end

  def init_views
    @board_view = append!(UIView, :board_view)

    @square_views = []
    (0..2).each do |i|
      (0..2).each do |j|
        sq_view = find(@board_view).append(UIView, :square_view).layout(
          left: (j * 82),
          top: (i * 82),
          width: 76,
          height: 76
        ).get

        find(sq_view).tag(index: (3 * i + j))
        @square_views[3 * i + j] = sq_view
      end
    end

    @prompt = append!(UILabel, :primary_prompt)
    @second_prompt = append!(UILabel, :secondary_prompt)
    find(@second_prompt).hide
  end

  def game_over
    if @game.tied?
      find(@prompt).style { |style| style.text = 'Tie game!' }
    else
      find(@prompt).style { |style| style.text = @game.winner == :human ? 'You win!' : 'I win!' }

      winning_squares = @game.winning_set.map { |index| @square_views[index] }
      find(winning_squares).animations.blink
    end

    find(@second_prompt).show

    @feedback = UINotificationFeedbackGenerator.alloc.init
    @feedback.prepare

    find(@board_view).on(:long_press) do
      @feedback.notificationOccurred(UINotificationFeedbackTypeSuccess)
      @feedback = nil
      open MenuScreen.new
    end
  end

  def update_views
    update_prompt
    (0..8).each do |i|
      square = @game.board.grid[i] || :blank
      find(@square_views[i]).apply_style(square)
    end
  end

  def update_prompt
    find(@prompt).style do |style|
      style.text = @game.current_player == :human ? 'Make your move!' : 'My turn!'
    end
  end
end
