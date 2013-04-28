class MainScene < GameScene

  draw :space, model: "metro::ui::space"

  draw :hero

  draw :villain, position: Game.center + Point.at(0,150), turn_amount: 0.005

  draw :score_board, color: "rgba(143,188,143,0.0)"

  after 15.tick do
    animate :score_board, to: { alpha: 204 }, interval: 2.seconds
  end

  draws :speech_bubble

  def build_game_walls
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

    # space.space.add_collision_handler(:wall,:hero) do
    # end
  end

  def prepare_transition_from(old_scene)
    self.theme = old_scene.theme
    villain.position = old_scene.villain.position
    hero.position = old_scene.hero.position
  end

  attr_accessor :theme

  def show
    window.hide_cursor

    @elapsed_ticks = 0

    space.add_object(hero)
    space.add_object(villain)

    build_game_walls

    space.space.add_collision_handler(:villain,:hero) do
      transition_to :death
    end
  end

  def ai
    @ai ||= ComplexApproach.new(self,hero,villain)
  end

  def villain_say(text)
    speech_bubble.text = text
    animate :villain, to: { green: 0, blue: 0 }, interval: 1.seconds
    animate :speech_bubble, to: { alpha: 255 }, interval: 2.seconds do
      after 1.second do
        animate :villain, to: { green: 255, blue: 255 }, interval: 1.seconds
        animate :speech_bubble, to: { alpha: 0 }, interval: 2.seconds
      end
    end
  end

  def score_based_on_position
    distance =  hero.body.p.dist(villain.body.p)
    if distance < 100
      1
    elsif distance < 200
      0.5
    elsif distance < 300
      0.25
    elsif distance < 400
      0.1
    else
      0
    end
  end

  def update
    @elapsed_ticks += 1

    speech_bubble.position = villain.position

    ai.level = (@elapsed_ticks / 10.seconds) + 1
    ai.update

    # To ensure the song will re-play when finished
    theme.play

    space.step
    space.clean_up

    score_board.score += score_based_on_position
  end

end