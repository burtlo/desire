class Villain < Metro::UI::Sprite

  property :pulsing, type: :animation, path: "villain.png",
    dimensions: Dimensions.of(128,128), time_per_image: 30

  property :ring, type: :animation, path: "villain.png",
    dimensions: Dimensions.of(128,128), time_per_image: 30

  property :ring_color, type: :color, default: "rgba(127,127,127,0.3)"

  property :outer_ring, type: :animation, path: "villain.png",
    dimensions: Dimensions.of(128,128), time_per_image: 30

  property :outer_ring_color, type: :color, default: "rgba(127,127,127,0.2)"

  property :turn_amount, default: 0

  def image
    pulsing.image
  end

  property :mass, default: 10
  property :moment_of_interia, default: 1000000

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
      new_shape = CP::Shape::Circle.new(body,48.0,CP::Vec2.new(0,0))
      new_shape.collision_type = :villain
      new_shape.e = 0.0
      new_shape.sensor = false
      new_shape
    end
  end

  def update
    body.a += turn_amount
    self.position = Point.at(body.p.x,body.p.y)
  end

  def draw
    dangle = body.a.to_degrees
    image.draw_rot x, y, z_order, angle, center_x, center_y, x_factor, y_factor, color

    ring.image.draw_rot x, y, z_order, angle, center_x, center_y, 4.0, 4.0, ring_color
    outer_ring.image.draw_rot x, y, z_order, angle, center_x, center_y, 6.0, 6.0, outer_ring_color
    # image.draw_rot(x,y,z_order,dangle,factor_x,factor_y)

    # dim = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
    # border = create "metro::ui::border", position: Point.at(x - 48,shape.bb.t), dimensions: dim
    # border.draw

  end

end