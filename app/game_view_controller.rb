# frozen_string_literal: true

class GameViewController < UIViewController
  SQUARE_SIZE = 80
  COLORS = {
    0 => rmq.color('#87A5C8'),
    1 => rmq.color('#AC835F'),
    nil => rmq.color('#F2F2F2')
  }.freeze

  def viewDidLoad
    init_views
    new_game
  end

  def touchesEnded(_touches, withEvent: event)
    index = (0..8).find { |i| event.touchesForView(@square_views[i]) }
    @game.move(index) unless index.nil?
    update_view
    return game_over if @game.over?

    app.after 1 do
      index = Computer.choose_move(@game)
      @game.move(index) unless index.nil?
      update_view
      game_over if @game.over?
    end
  end

  private

  def new_game
    @game = Game.new

    app.after 1 do
      index = Computer.choose_move(@game)
      @game.move(index) unless index.nil?
      update_view
    end
  end

  def init_views
    rmq(view).style { |st| st.background_color = rmq.color('#FDFDFD') }

    # view for the board
    @board_view = rmq.append(UIView).layout(
      width: 240,
      height: 240,
      centered: :both
    ).get

    # views for the square
    @square_views = []
    (0..2).each do |i|
      (0..2).each do |j|
        sq_view = rmq.append(UIView).layout(
          left: j * (SQUARE_SIZE + 2),
          top: i * (SQUARE_SIZE + 2),
          width: SQUARE_SIZE - 4,
          height: SQUARE_SIZE - 4
        ).get

        sq_view.style do |st|
          st.corner_radius = 5
          st.backtround_color = rmq.color('#F2F2F2')
        end

        @square_views[3 * i + j] = sq_view
        rmq(@board_view).append(sq_view)
      end
    end

    view.addSubview(@board_view)

    @label = rmq.append(UILabel).layout(
      below_prev: 20,
      centered: :horizontal,
      width: 280,
      height: 44
    ).get

    rmq(@label).style do |st|
      st.text_alignment = :center
      st.font = rmq.font.font_with_name('helvetica-light', 24)
    end

    rmq(view).append(@label)
  end

  def game_over
    alert_params = nil
    alert_params = { title: 'Tie game!', message: nil, actions: ['Lame'] } if @game.tied?
    alert_params = { title: 'You win!', message: nil, actions: ['Yay'] } if @game.won_by?(1)
    alert_params = { title: 'I win!', message: nil, actions: ['Damn'] } if @game.won_by?(0)

    app.alert(alert_params) do
      new_game
    end
  end

  def update_view
    rmq(@label).style do |st|
      st.text = @game.current_player.zero? ? 'My turn!' : 'Make your move!'
    end

    (0..8).each do |i|
      rmq(@square_views[i]).style do |st|
        st.background_color = COLORS[@game.board.grid[i]]
      end
    end
  end
end
