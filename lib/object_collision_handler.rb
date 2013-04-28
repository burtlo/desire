class ObjectCollisionHandler
  def begin(a, b, arbiter)
    puts "begin"
    true
  end

  def pre_solve(a, b)
    puts "pre_solve"
    true
  end

  def post_solve(arbiter)
    puts "post_solve"
    true
  end

  def separate
    puts "separate"
    true
  end
end