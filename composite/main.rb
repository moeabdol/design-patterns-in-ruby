require_relative "make_batter_task"
require_relative "make_cake_task"

cake_batter = MakeBatterTask.new
puts "#{cake_batter.time_required} minutes to make #{cake_batter.title}"

cake = MakeCakeTask.new
puts "#{cake.time_required} minutes to make #{cake.title}"
