require 'nokogiri'
require 'httparty' 

#creates and returns a map of {sport name => roster link} for all men's sports
def getMensSportsMap
	url = "https://ohiostatebuckeyes.com"
	response = HTTParty.get url
	doc = Nokogiri::HTML(response)
	#selects the anchors to the sports pages, whose child is the name of the sport
	anchors = doc.css('a[title="Men\'s Sports"] + div').css('li > a')
	map={}
	until anchors.empty? do
		node = anchors.pop
		sport=node.child.to_s.upcase
		sport.sub!('&AMP;','&') if sport.include? "&AMP;"
		roster = "https://ohiostatebuckeyes.com" + node.attribute("href").to_s+"/roster"
		map[sport] = roster
	end
	map
end

#creates and returns a map of {sport name => roster link} for all women's sports
def getWomensSportsMap
	url = "https://ohiostatebuckeyes.com"
	response = HTTParty.get url
	doc = Nokogiri::HTML(response)
	#selects the anchors to the sports pages, whose child is the name of the sport
	anchors = doc.css('a[title="Women\'s Sports"] + div').css('li > a')
	map={}
	until anchors.empty? do
		node = anchors.pop
		sport=node.child.to_s.upcase
		sport.sub!('&AMP;','&') if sport.include? "&AMP;"
		roster = "https://ohiostatebuckeyes.com" + node.attribute("href").to_s+"/roster"
		map[sport] = roster
	end
	map
end

#method for processing a single roster page. it prints out the player heights, and the average height for the sport.
def processRoster url
	unparse_page = HTTParty.get(url)
	parse_page = Nokogiri::HTML(unparse_page)

	h = height parse_page
	#puts h.length
	n = names parse_page
	#puts n.length
	heightInInches = feetToInches(h)
	if heightInInches.inject(0){|sum,x| sum +x} != 0 
		
		

		displayNameHeight h,heightInInches,n
	
		averageHeight = average(heightInInches)
		puts "\nAverage height in inches is: #{averageHeight}"

		feet = averageHeight/12
		num = averageHeight - feet.to_i * 12
		puts "Average height in feet is: #{feet.to_i}\' #{num}\""
	else
		puts "No available height data for this sport."
	end
end


