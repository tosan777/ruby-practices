(1..20).each do |i|
 if i % 15 == 0
  p "FizzBuzz"
 elsif i % 5 == 0
  p "Buzz"
 elsif i % 3 == 0
  p "Fizz"
 else
  p i
 end
end
