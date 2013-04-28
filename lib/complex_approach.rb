class ComplexApproach

  def initialize(scene,hero,villain)
    @scene = scene
    @hero = hero
    @villain = villain
  end

  attr_reader :scene, :hero, :villain

  def level
    @level ||= 1
  end

  def level=(value)
    @level = value
  end

  def time_for_each_approach
    [ (15.seconds / level), 5.seconds ].max
  end

  attr_writer :current_approach_time

  def current_approach_time
    @current_approach_time ||= 0
  end

  def current_approach
    if @current_approach.nil? || current_approach_time > time_for_each_approach
      select_new_approach
    end

    @current_approach
  end

  def select_new_approach
    self.current_approach_time = 0

    @current_approach = approaches.sample.new(hero,villain,level)

    if @current_approach.is_a?(NotInterestedApproach)
      scene.villain_say(angry_sayings.sample)
    else
      scene.villain_say(sayings.sample)
    end

  end

  def approaches
    @approaches ||= [ LungeApproach, MostInterestedWhenClose, MostInterestedWhenFar, NotInterestedApproach ]
  end

  def update
    self.current_approach_time += 1
    current_approach.update
  end

  def angry_sayings
    @angry_sayings ||= begin
      [ "I don't need you",
        "Stay away from me",
        "I wish you would leave",
        "Go AWAY!",
        "I am hurting",
        "I never wanted you",
        "You're not worth it",
        "I hate you",
        "You're not perfect" ]
    end
  end

  def sayings
    @sayings ||= begin
      [ "Come to me",
        "You are so close",
        "I need you",
        "I want you",
        "You can save me",
        "Just a touch",
        "Come closer",
        "I can feel your warmth",
        "I must have you",
        "You are so precious",
        "I want to hold you",
        "Please, I'm begging" ]
    end
  end

end