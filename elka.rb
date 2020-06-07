# ruby elka.rb 10 output.txt

if ARGV.size != 2
  STDERR.puts 'Set 2 arguments: stages count and output file'
  exit(1)
end

stages_count = ARGV[0].to_i

File.open(ARGV[1], 'w') do |file|
  (1..stages_count).each do |stage|
    offset_count = (stages_count - stage) * 2
    offset = ' ' * offset_count

    stars_count = stage * 4 - 3
    stars = '*' * stars_count

    ball_left = false
    if stage > 1
      if stage.even?
        stars = '@' + stars
        ball_left = true
      else
        stars += '@'
      end
    end

    offset = ' ' + offset unless ball_left

    file.puts(offset + 'w') if stage == 1
    file.puts(offset + stars)
  end

  offset_count = (stages_count * 2) - (stages_count / 2) - 1
  offset = ' ' * offset_count
  2.times do
    file.puts(offset + 'T' * stages_count)
  end
end
