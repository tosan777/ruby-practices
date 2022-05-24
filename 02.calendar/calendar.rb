require 'date'
require 'optparse'


def optparse
  opt = OptionParser.new

  now = Time.now

  opt.on('-m [m]') do |m|
    if m == nil
       @month = now.month
     else
       @month = m.to_i
    end
  end

  opt.on('-y [y]') do |y|
    if y == nil
      @year = now.year
    else
      @year = y.to_i
    end
  end

  opt.parse!(ARGV)
end


def calendar(optparse)

  first_day = Date.new(@year, @month, 1).day
  last_day = Date.new(@year, @month, -1).day

  print "#{@month}月 #{@year}年".center(20)
  puts "\n"

  day_of_week = ["日","月","火","水","木","金","土"]
  puts day_of_week.join(' ')

  first_day = Date.new(@year, @month, 1).day
  last_day = Date.new(@year, @month, -1).day
  first_wday = Date.new(@year, @month, 1).wday
  day_of_week[first_wday]

  (first_wday).times do |t|
    print "   " * first_day
  end

  (first_day..last_day).each do |d|
    printf d.to_s.rjust(3)
    puts "\n" if (d + first_wday) % 7 === 0
  end
end


calendar(optparse)
