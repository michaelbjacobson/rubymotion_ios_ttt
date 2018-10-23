# frozen_string_literal: true

class MenuScreen < PM::Screen
  title 'Tic-Tac-Toe'
  stylesheet MenuScreenStylesheet

  def on_load
    @human_goes_first = append!(UILabel, :human_goes_first)
    @computer_goes_first = append!(UILabel, :computer_goes_first)

    find(@human_goes_first).on(:tap) { open GameScreen.new(first_player: :human) }
    find(@computer_goes_first).on(:tap) { open GameScreen.new(first_player: :computer) }
  end
end
