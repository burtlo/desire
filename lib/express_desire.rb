class ExpressDesire

  def initialize(scene,ticks)
    @scene = scene
    @ticks = ticks
    @current_tick = 0
  end

  attr_reader :scene

  attr_reader :ticks, :current_tick

  def self.sayings
    @sayings ||= begin
      [ "Come to me",
        "You are so close",
        "I need you",
        "I want you",
        "I am hurting",
        "You are special",
        "You can save me",
        "Just a touch",
        "Come closer",
        "I can feel your warmth",
        "I must have you",
        "You're mine",
        "You are so precious",
        "I want to hold you",
        "Please, I'm begging" ]
    end
  end

  def action_tick?
    current_tick % ticks == 0
  end

  def update
    @current_tick += 1
    return unless action_tick?
    scene.villain_say(self.class.sayings.sample)
  end

end


class ExpressAnger < ExpressDesire

  def sayings
    @sayings ||= begin
      [ "I don't need you",
        "Stay away from me",
        "I wish you would leave",
        "Go AWAY!",
        "I never wanted you",
        "You're not worth it",
        "I hate you",
        "You're not perfect" ]
    end
  end

end