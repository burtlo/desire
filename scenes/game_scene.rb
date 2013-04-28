class GameScene < Metro::Scene

  #
  # The game scene is a place where you can define actors and
  # events here that will be present within all the subclassed
  # scenes.

  #
  # This animation helper will fade in and fade out information.
  #
  def fade_in_and_out(name)
    animate name, to: { alpha: 255 }, interval: 2.seconds do
      after 1.second do
        animate name, to: { alpha: 0 }, interval: 1.second do
          yield if block_given?
        end
      end
    end
  end

  def build_game_walls(space)
    wall_body = CP::Body.new_static

    dim = Game.bounds

    top_shape = CP::Shape::Segment.new(wall_body,CP::Vec2.new(dim.left,dim.top),CP::Vec2.new(dim.right,dim.top),2)
    left_shape = CP::Shape::Segment.new(wall_body,CP::Vec2.new(dim.left,dim.top),CP::Vec2.new(dim.left,dim.bottom),2)
    right_shape = CP::Shape::Segment.new(wall_body,CP::Vec2.new(dim.right,dim.top),CP::Vec2.new(dim.right,dim.bottom),2)
    bottom_shape = CP::Shape::Segment.new(wall_body,CP::Vec2.new(dim.left,dim.bottom),CP::Vec2.new(dim.right,dim.bottom),2)

    [ top_shape, left_shape, right_shape, bottom_shape ].each do |shape|
      shape.sensor = false
      shape.collision_type = :wall
      space.space.add_shape(shape)
    end
  end

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

end
