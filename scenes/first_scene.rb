class FirstScene < GameScene

  draw :space, model: "metro::ui::space"

  draw :hero, position: Game.center

  draw :villain, color: "rgba(255,255,255,0.0)", ring_color: "rgba(127,127,127,0.0)",
    outer_ring_color: "rgba(127,127,127,0.0)", position: Game.center + Point.at(0,150)

  draw :speech_bubble

  def villain_say(text,&block)
    speech_bubble.text = text
    animate :villain, to: { green: 0, blue: 0 }, interval: 1.seconds
    animate :speech_bubble, to: { alpha: 255 }, interval: 2.seconds do
      after 1.second do
        animate :villain, to: { green: 255, blue: 255 }, interval: 1.seconds
        animate :speech_bubble, to: { alpha: 0 }, interval: 2.seconds, &block
      end
    end
  end

  after 3.seconds do
    animate :villain, to: { alpha: 255 }, interval: 2.seconds do
      animate :villain, to: { ring_color_alpha: 76 }, interval: 2.seconds do
        animate :villain, to: { outer_ring_color_alpha: 51 }, interval: 2.seconds
          villain_say "I desire you" do
            transition_to :main
          end
      end
    end

  end

  def show
    window.hide_cursor
    space.add_object(hero)
  end

  def update
    speech_bubble.position = villain.position
    space.step
    space.clean_up
  end

  attr_accessor :theme

  def prepare_transition_from(old_scene)
    self.theme = old_scene.theme
  end

end
