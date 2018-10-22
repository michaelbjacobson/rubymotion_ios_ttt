# frozen_string_literal: true

# GameScreenStylesheet
class GameScreenStylesheet < RubyMotionQuery::Stylesheet

  def application_setup
    rmq.color.add_named :pink, '#CC385D'
    rmq.color.add_named :teal, '#9AD1DC'
    rmq.color.add_named :light_gray, '#F5F5F5'
  end

  def root_view(style)
    style.background_color = rmq.color('#FDFDFD')
  end

  def board_view(style)
    style.frame = {
      width: 240,
      height: 240,
      centered: :both
    }
  end

  def square_view(style)
    style.corner_radius = 5
    style.background_color = rmq.color.light_gray
  end

  def primary_prompt(style)
    style.frame = {
        below_prev: 20,
        centered: :horizontal,
        width: 280,
        height: 44
    }
    style.text_alignment = :center
    style.color = rmq.color('#191919')
    style.font = rmq.font.font_with_name('SourceSansPro-Light', 28)
  end

  def secondary_prompt(style)
    style.frame = {
        below_prev: 20,
        width: 280,
        height: 44
    }
    style.text_alignment = :center
    style.color = rmq.color('#191919')
    style.font = rmq.font.font_with_name('SourceSansPro-Light', 20)
    style.text = 'Press and hold the grid to play again.'
    style.resize_to_fit_text
    style.centered = :horizontal
  end

  def computer(style)
    style.background_color = rmq.color.teal
  end

  def human(style)
    style.background_color = rmq.color.pink
  end
end
