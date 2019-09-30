require 'nokogiri'
require 'httparty'


#return a array with all players' height 
def height parse_page
   
	heights= parse_page.css("span.ohio-square-blocks__subtitle")
	height= heights.map do |n|
		if n.text[7,4].include?("-")
			n.text[7,4].chomp 
		else
			n = "0-0"
		end
	end
	height.compact
end

#function to find the average height in inches
def average(arr)
	i = 0
	total = 0
	zeroCount = 0
	while i < arr.length
		if arr[i] != 0
		total = total + arr[i]
		else 
		zeroCount += 1
		end
		i = i + 1
	end
	if total != 0	
		result = total.fdiv(arr.length - zeroCount) 
	else 
		result = 0
	end
	return result
end

#return an array of player names
def names parse_page
	names = parse_page.css("h3.ohio-square-blocks__title")
    	name= names.map do |n|
        	n.text unless n.text[0]=="\n"
	end
	name.compact
end

#function to convert feet to inches
def feetToInches(height)
	arr = Array.new height.length, 0
	height.length.times do |i|
		index = height[i]
		feet, inches = index.scan(/\d+/).map { |n| n.to_i }
		arr[i] = (feet * 12 + inches)
	end
	return arr
end

#Prints out The name of players and their repsective heights
def displayNameHeight h,c,n
	i = 0
	while i < n.length
		puts "Name:   #{n[i]}"
		puts  "Height: #{h[i]} / #{c[i]} inches"
		i = i + 1
	end

end

