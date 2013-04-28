class MainScene < GameScene

  draw :space, model: "metro::ui::space"

  draws :hero, :speech_bubble

  draw :villain, from: :previous_scene

  draw :villain1, model: "little_villain", position: Game.center + Point.at(-200,-200)
  draw :villain2, model: "little_villain", position: Game.center + Point.at(-200,200)
  draw :villain3, model: "little_villain", position: Game.center + Point.at(200,-200)
  draw :villain4, model: "little_villain", position: Game.center + Point.at(200,200)

  draw :score_board, color: "rgba(143,188,143,0.0)"

  attr_accessor :theme

  after 15.tick do
    animate :score_board, to: { alpha: 204 }, interval: 2.seconds
  end

  def prepare_transition_from(old_scene)
    self.theme = old_scene.theme
    # villain.position = old_scene.villain.position
    hero.position = old_scene.hero.position
  end

  def show
    window.hide_cursor

    @elapsed_ticks = 0

    space.add_object(hero)
    space.add_object(villain)
    space.add_object(villain1)
    space.add_object(villain2)
    space.add_object(villain3)
    space.add_object(villain4)

    build_game_walls(space)

    space.space.add_collision_handler(:villain,:hero) do
      transition_to :death
    end
  end

  def ai
    @ai ||= [ ComplexApproach.new(self,hero,villain) ]
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

  def hide_villain(&block)
    animate :villain, to: { ring_color_alpha: 0 }, interval: 1.seconds
    animate :villain, to: { outer_ring_color_alpha: 0 }, interval: 1.5.seconds
    animate :villain, to: { alpha: 0 }, interval: 2.seconds, &block
  end

  def little_villains
    @little_villains ||= [ villain1, villain2, villain3, villain4 ]
  end

  def enable_little_villains
    little_villains.each {|little_villain| enable_little_villain(little_villain) }
  end

  def enable_little_villain(little_villain)
    animate :villain1, to: { alpha: 255 }, interval: 1.seconds do
      ai.push AggressiveApproach.new(self,hero,little_villain)
    end
  end

  def update
    @elapsed_ticks += 1

    speech_bubble.position = villain.position

    ai_level = (@elapsed_ticks / 10.seconds) + 1

    if ai_level == 1 and ai.count < 2
      enable_little_villain(villain1)
    end

    ai.each do |intelligence|
      intelligence.level = ai_level
      intelligence.update
    end

    # if ai.level == 2 and not ai.is_a?(NoApproach)
    #   @ai = NoApproach.new(self,hero,villain)
    #   villain_say "I will have you" do
    #     hide_villain do
    #       enable_little_villains
    #     end

    #   end
    # end

    # To ensure the song will re-play when finished
    # theme.play

    space.step
    space.clean_up

    score_board.score += score_based_on_position
  end

end