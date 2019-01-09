# frozen_string_literal: true

# MenuScreen
class MenuScreen < PM::Screen
  title 'Tic-Tac-Toe'
  stylesheet MenuScreenStylesheet

  def on_load
    setup_views
    setup_event_listeners
  end

  private

  def setup_views
    append!(UILabel, :game_title)
    append!(UILabel, :question)
    @human_goes_first = append!(UILabel, :human_goes_first)
    append!(UILabel, :or)
    @computer_goes_first = append!(UILabel, :computer_goes_first)
  end

  def setup_event_listeners
    find(@human_goes_first, @computer_goes_first).on(:tap) do |button|
      @first_player = button == @human_goes_first ? :human : :computer
      open GameScreen.new(first_player: @first_player)
    end
  end
end
