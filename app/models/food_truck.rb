class FoodTruck < ApplicationRecord



  def self.scrape_toronto_food_trucks()
    url = "http://torontofoodtrucks.ca"
  data = Nokogiri::HTML(open(url))
  food_truck_information = data.css('.truck')
    hash = {}

    for i in (0..food_truck_information.length-1)
        truck_name = food_truck_information[i].at_css('.title a').text.gsub(/\s+/, " ").strip
        hours = food_truck_information[i].at_css('.info .open').text.gsub(/\s+/, " ").strip
        location = food_truck_information[i].at_css('.info a').text.gsub(/\s+/, " ").strip
        hash[truck_name] = [hours, location]
    end
    return hash
end
    def self.save_info_from_hash(hash)

        for index in (0..hash.length-1)
            FoodTruck.new({
                truck_name: hash.keys[index],
                time: hash[index][0],
                location: hash[index][1],
                latitude: Geocoder.coordinates(hash[index][1])[0],
                longitude: Geocoder.coordinates(hash[index][1])[1]

                # eg : Geocoder.coordinates("25 Main St, Cooperstown, NY")
                # returns [42.700149, -74.922767]
                })
        end
    end


#     nav = doc.css('div#ttBR_row_8').each do |row|
#   # puts row.content
#   TimeTable.create({
#     start_city: row.content[0], 
#     destination_city: row.content[1], 
#     departure_time: row.content[2], 
#     arrival_time: row.content[3]
# end
end
