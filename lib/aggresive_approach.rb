class AggressiveApproach

  attr_reader :scene, :hero, :villain

  def initialize(scene,hero,villain)
    @scene = scene
    @hero = hero
    @villain = villain
  end

    def level
    @level ||= 1
  end

  def level=(value)
    @level = value
  end

  def time_for_each_approach
    @time_for_each_approach ||= 10.seconds
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
  end

  def approaches
    @approaches ||= [ DirectApproach ]
  end

  def update
    self.current_approach_time += 1
    current_approach.update
  end

end