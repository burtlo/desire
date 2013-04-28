class SpeechBubble < Metro::Model

  property :image, path: "speech.png"

  property :position, default: Game.center
  # property :ding, type: :sample, path: "pickup.wav"

  property :color, default: "rgba(75,75,75,0.0)"

  property :label, type: :model do
    create "metro::ui::label", text: "", position: position,
      font: { size: 20 }, color: "rgba(255,0,0,0)", align: 'center'
  end

  property :dimensions do
    Dimensions.of label.width, label.height
  end

  def bounds
    Bounds.new left: position.x, right: (position.x + width),
      top: position.y, bottom: (position.y + height)
  end

  def alpha=(value)
    label.alpha = value
    color.alpha = [ value, 225 ].min
  end

  def alpha
    label.alpha
  end

  def text=(value)
    label.text = value
  end

  def text
    label.text
  end

  def update
    label.position = (position + Point.at(128,-96))
  end

  def draw
    image.draw_rot(x + 128,y - 86,z_order,0,0.5,0.5,1.0,1.0,color)
    # image.draw_rot(x,y,z_order,0.5,0.5,1.0,1.0,alpha)
    label.draw
  end

end
