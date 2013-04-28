class TitleScene < GameScene

  play :theme, song: "desire.wav"

  draw :title, position: Game.center

  draw :menu, options: [ 'Begin', 'Exit' ],
    position: (Game.center + Point.at(0,200))

  event :on_up, KbEscape do
    exit
  end

  event :on_down, MsLeft do |event|
    mouse_point = event.mouse_point

    if menu.enabled && menu.bounds.contains?(mouse_point)
      menu.selection_sample.play
      send menu.options.selected_action
    end
  end

  event :on_mouse_movement do |event|
    mouse_point = event.mouse_point

    if menu.enabled && menu.bounds.contains?(mouse_point)
      menu.options.each do |option|
        if option.bounds.contains?(mouse_point)
          menu.options.current_selected_index = option
          menu.update_options
        end
      end
    end
  end

  def begin
    transition_to :first
  end

  def show
    window.show_cursor
  end


end