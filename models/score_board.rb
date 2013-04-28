class ScoreBoard < Metro::Model

  property :position, default: Point.at(10,10)
  # property :ding, type: :sample, path: "pickup.wav"

  property :score, default: 1

  property :color, default: "rgba(143,188,143,0.8)"

  property :label, type: :model do
    create "metro::ui::label", text: "", position: position,
      font: { size: 30 }, color: color
  end

  def alpha=(value)
    label.alpha = value
  end

  def alpha
    label.alpha.to_f
  end

  property :dimensions do
    Dimensions.of label.width, label.height
  end

  def bounds
    Bounds.new left: position.x, right: (position.x + width),
      top: position.y, bottom: (position.y + height)
  end

  def text
    "Desire: #{score.to_i}"
  end

  def draw
    label.text = text
    label.draw
  end

end