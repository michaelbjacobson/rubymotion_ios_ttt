# frozen_string_literal: true

# MenuScreenStylesheet
class MenuScreenStylesheet < ApplicationStylesheet

  def start_button(style)
    style.text_alignment = :center
    style.color = color.almost_white
    style.background_color = color.almost_black
    style.corner_radius = 5
    style.font = rmq.font.font_with_name('SourceSansPro-Light', 28)
  end

  def human_goes_first(style)
    start_button(style)
    style.text = 'Human goes first'
    style.frame = {
      width: (device.width - 100),
      height: 50,
      centered: :both
    }
  end

  def computer_goes_first(style)
    start_button(style)
    style.text = 'Computer goes first'
    style.frame = {
      width: (device.width - 100),
      height: 50,
      below_previous: 30,
      centered: :horizontal
    }
  end
end
