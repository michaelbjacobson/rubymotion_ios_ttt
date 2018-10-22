class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(app, options)
    open GameScreen
  end
end