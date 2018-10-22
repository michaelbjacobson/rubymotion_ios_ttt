# frozen_string_literal: true

# MainScreen
class GameScreen < PM::Screen
  title 'Tic-Tac-Toe'
  nav_bar false
  stylesheet GameScreenStylesheet

  FIRST_PLAYER = :computer
  SQUARE_SIZE = 80

  def on_load
    init_views
    new_game
    init_touch_listeners
  end

  private

  def init_touch_listeners
    rmq(@square_views).on(:tap) do |square|
      break if @game.over?
      break unless @game.current_player == :human

      index = rmq(square).tags[:index]
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
    if FIRST_PLAYER == :computer
      @game.swap_players
      index = Computer.choose_move(@game)
      @game.move(index) unless index.nil?
    end
    update_views
    rmq(@second_prompt).hide
  end

  def init_views
    @board_view = rmq.append(UIView, :board_view).get

    @square_views = []
    (0..2).each do |i|
      (0..2).each do |j|
        sq_view = rmq.append(UIView, :square_view).layout(
          left: j * (SQUARE_SIZE + 2),
          top: i * (SQUARE_SIZE + 2),
          width: SQUARE_SIZE - 4,
          height: SQUARE_SIZE - 4
        ).get

        rmq(sq_view).tag(index: (3 * i + j))
        @square_views[3 * i + j] = sq_view
        rmq(@board_view).append(sq_view)
      end
    end

    view.addSubview(@board_view)

    @prompt = rmq.append(UILabel, :primary_prompt).get
    rmq(view).append(@prompt)

    @second_prompt = rmq.append(UILabel, :secondary_prompt).get
    rmq(view).append(@second_prompt)
    rmq(@second_prompt).hide
  end

  def game_over
    if @game.tied?
      rmq(@prompt).style { |st| st.text = 'Tie game!' }
    else
      rmq(@prompt).style { |st| st.text = @game.winner == :human ? 'You win!' : 'I win!' }

      winning_squares = @game.winning_set.map { |index| @square_views[index] }
      rmq(winning_squares).animations.blink
    end

    rmq(@second_prompt).show

    @feedback = UINotificationFeedbackGenerator.alloc.init
    @feedback.prepare

    rmq(@board_view).on(:long_press) do
      @feedback.notificationOccurred(UINotificationFeedbackTypeSuccess)
      @feedback = nil
      rmq(@board_view).off(:long_press)
      new_game
    end
  end

  def update_views
    rmq(@prompt).style do |st|
      st.text = @game.current_player == :human ? 'Make your move!' : 'My turn!'
    end

    (0..8).each do |i|
      next if @game.board.grid[i].nil?

      player = @game.board.grid[i]
      rmq(@square_views[i]).apply_style(player)
    end
  end
end
