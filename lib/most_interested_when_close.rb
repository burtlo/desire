class MostInterestedWhenClose

  attr_reader :hero, :villain, :level

  def initialize(hero,villain,level)
    @hero = hero
    @villain = villain
    @level = level
  end

  def direction_towards_hero
    diff_x = hero.x - villain.x
    diff_x = diff_x / diff_x.abs
    diff_y = hero.y - villain.y
    diff_y = diff_y / diff_y.abs
    [ diff_x, diff_y ]
  end

  def closeness
    hero.body.p.dist(villain.body.p)
  end

  def optimal_distance
    100
  end

  def ratio
    optimal_distance / closeness * level * 4
  end

  def update
    x_dir, y_dir = direction_towards_hero
    impulse_vector = CP::Vec2.new(x_dir * ratio,y_dir * ratio)
    villain.body.apply_impulse(impulse_vector,CP::Vec2.new(0.0, 0.0))
  end

end
