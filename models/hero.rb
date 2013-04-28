class Hero < Metro::UI::Sprite

  property :pulsing, type: :animation, path: "hero.png",
    dimensions: Dimensions.of(64,64), time_per_image: 16

  def image
    pulsing.image
  end

  property :mass, default: 10
  property :moment_of_interia, default: 1000000

  def hero_bounds
    @hero_bounds ||= Game.bounds.shrink(left: 32, right: 32, top: 32, bottom: 32)
  end

  event :on_mouse_movement do |event|
    new_position = hero_bounds.clamp(event.mouse_point)
    self.body.p = CP::Vec2.new(new_position.x,new_position.y)
    self.position = new_position
  end

  def body
    @body ||= begin
      body = CP::Body.new(mass,moment_of_interia)
      body.p = CP::Vec2.new(x,y)
      body.v = CP::Vec2::ZERO
      body.a = 0
      body
    end
  end

  def shape
    @shape ||= begin
      new_shape = CP::Shape::Circle.new(body,32.0,CP::Vec2.new(0,0))
      new_shape.collision_type = :hero
      new_shape.e = 0.0
      new_shape.sensor = false
      new_shape
    end
  end

  def draw
    dangle = body.a.to_degrees
    image.draw_rot(x,y,z_order,dangle)

    # dim = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
    # border = create "metro::ui::border", position: Point.at(x - 32,shape.bb.t), dimensions: dim
    # border.draw

  end

end