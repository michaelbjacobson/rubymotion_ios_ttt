class AppDelegate < PM::Delegate
  status_bar true, animation: :fade

  def on_load(_app, _options)
    open MenuScreen
  end
end
