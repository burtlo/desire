class NotInterestedApproach

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

  def random_direction_away_from_hero
    x_dir, y_dir = direction_towards_hero

    direction = [ :x_dir, :y_dir, :both ].sample

    x_dir *= -1 if direction == :x_dir || direction == :both
    y_dir *= -1 if direction == :y_dir || direction == :both

    [ x_dir, y_dir ]
  end

  def factor
    level * 4
  end

  def update
    x_dir, y_dir = random_direction_away_from_hero
    impulse_vector = CP::Vec2.new(x_dir * factor,y_dir * factor)
    villain.body.apply_impulse(impulse_vector,CP::Vec2.new(0.0, 0.0))
  end

end