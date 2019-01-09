# frozen_string_literal: true

# GameScreenStylesheet
class GameScreenStylesheet < ApplicationStylesheet
  def board_view(style)
    style.frame = {
      width: 240,
      height: 240,
      centered: :both
    }
  end

  def square_view(style)
    style.corner_radius = 5
    style.background_color = color.light_grey
  end

  def primary_prompt(style)
    style.frame = {
      below_prev: 20,
      centered: :horizontal,
      width: 280,
      height: 44
    }
    style.text_alignment = :center
    style.color = color.almost_black
    style.font = font.medium
  end

  def secondary_prompt(style)
    style.frame = {
      below_prev: 20,
      width: 280,
      height: 44
    }
    style.text_alignment = :center
    style.color = color.almost_black
    style.font = font.small
    style.text = 'Press and hold the grid to play again.'
    style.resize_to_fit_text
    style.centered = :horizontal
  end

  def computer(style)
    style.background_color = color.teal
  end

  def human(style)
    style.background_color = color.pink
  end

  def blank(style)
    style.background_color = color.light_grey
  end
end
