# frozen_string_literal: true

# ApplicationStylesheet
class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup
    color.add_named :pink, '#CC385D'
    color.add_named :teal, '#9AD1DC'
    color.add_named :light_grey, '#F5F5F5'
    color.add_named :almost_white, '#FDFDFD'
    color.add_named :almost_black, '#191919'
  end

  def root_view(style)
    style.background_color = color.almost_white
  end
end
