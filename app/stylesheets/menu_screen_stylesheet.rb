# frozen_string_literal: true

# MenuScreenStylesheet
class MenuScreenStylesheet < ApplicationStylesheet
  def game_title(style)
    style.font = font.large
    style.color = color.almost_black
    style.text_alignment = :center
    style.text = 'Tic-Tac-Toe'
    style.resize_to_fit_text
    style.frame = {
      centered: :horizontal,
      top: (device.height / 2) - 250
    }
  end

  def start_button(style)
    style.text_alignment = :center
    style.color = color.almost_white
    style.background_color = color.almost_black
    style.corner_radius = 5
    style.font = font.medium
  end

  def question(style)
    style.text = 'Who should go first?'
    style.text_alignment = :center
    style.color = color.almost_black
    style.font = font.medium
    style.resize_to_fit_text
    style.frame = {
      centered: :horizontal,
      below_previous: 25
    }
  end

  def or(style)
    style.text = 'Or'
    style.text_alignment = :center
    style.color = color.almost_black
    style.font = font.small
    style.resize_to_fit_text
    style.frame = {
      centered: :horizontal,
      below_previous: 10
    }
  end

  def human_goes_first(style)
    start_button(style)
    style.text = 'Human'
    style.frame = {
      width: (device.width - 200),
      height: 50,
      below_previous: 150,
      centered: :horizontal
    }
  end

  def computer_goes_first(style)
    start_button(style)
    style.text = 'Computer'
    style.frame = {
      width: (device.width - 200),
      height: 50,
      below_previous: 10,
      centered: :horizontal
    }
  end
end
