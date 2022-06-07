require 'date'
require 'optparse'

def optparse
  opt = OptionParser.new

  now = Time.now

  month = opt.on('-m [m]') do |m|
    month = m || now.month
  end

  year = opt.on('-y [y]') do |y|
    year = y || now.year
  end

  opt.parse!(ARGV)
  return month, year
end

def calendar(optparse)
  month = optparse[0].to_i
  year = optparse[1].to_i
  first_day = Date.new(year, month, 1).day
  last_day = Date.new(year, month, -1).day
   
  print "#{month}月 #{year}年".center(20)
  puts "\n"
    
  day_of_week = ["日","月","火","水","木","金","土"]
  puts day_of_week.join(' ')
   
  first_day = Date.new(year, month, 1).day
  last_day = Date.new(year, month, -1).day
  first_wday = Date.new(year, month, 1).wday
  day_of_week[first_wday]

  print "   " * first_wday 
 
  (first_day..last_day).each do |d|
    printf d.to_s.rjust(3)
    puts "\n" if (d + first_wday) % 7 === 0
  end
end
 
calendar(optparse)
