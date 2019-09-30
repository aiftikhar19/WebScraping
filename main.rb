require_relative 'calculations'
require_relative 'parsing'
require 'nokogiri'
require 'httparty'

system "clear"
puts "~~~~~~~~ OSU Athlete Height Analysis ~~~~~~~~"
puts "Height statistics for sports at The Ohio State University"
puts "Warning: a few sports do not have height data posted on their website."
puts "\nMen's Sport or Women's Sport? ('m' or 'w')"
choice2 = gets.chomp.upcase
case choice2
when 'M'
	map, indices = getMensSportsMap, []
	map.each do |sport, link| 
	indices << sport
	puts (indices.length-1).to_s+". "+sport 
	end
	puts "\nchoose a sport: "
	choice3 = gets.chomp.to_i
	if (choice3>indices.length) then puts "invalid input"
	else processRoster(map[indices[choice3].upcase]) end	
when 'W'
	map, indices = getWomensSportsMap, []
	map.each do |sport, link| 
	indices << sport
	puts (indices.length-1).to_s+". "+sport 
	end
	puts "\nchoose a sport: "
	choice3 = gets.chomp.to_i
	if (choice3>indices.length) then puts "invalid input"
	else processRoster(map[indices[choice3].upcase]) end	
else 
	puts "invalid input"
end







