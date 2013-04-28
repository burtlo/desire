class LungeApproach

  attr_reader :hero, :villain, :level

  attr_reader :current_tick

  def initialize(hero,villain,level)
    @hero = hero
    @villain = villain
    @level = level
    @current_tick = 0
  end

  def ticks
    60
  end

  def direction_towards_hero
    diff_x = hero.x - villain.x
    diff_y = hero.y - villain.y
    [ diff_x, diff_y ]
  end

  def action_tick?
    current_tick % ticks == 0
  end

  def factor
    level / 2
  end

  def update
    @current_tick += 1

    return unless action_tick?

    x_dir, y_dir = direction_towards_hero
    impulse_vector = CP::Vec2.new(x_dir * factor,y_dir * factor)
    villain.body.apply_impulse(impulse_vector,CP::Vec2.new(0.0, 0.0))

  end

end
