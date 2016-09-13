class FoodtrucksController < ApplicationController
    def index
        info = FoodTruck.scrape_toronto_food_trucks()
        FoodTruck.save_info_from_hash(info)
        @trucks = FoodTruck.all
            @hash = Gmaps4rails.build_markers(@trucks) do |user, marker|
          marker.lat user.latitude
          marker.lng user.longitude
        end
    end
    def create
        @truck = FoodTruck.create(foodtruck_params)
    end

    private
    def foodtruck_params
        params.require(:foodtruck).permit(:truck_name, :time, :location, :latitude, :longitude)
    end
end
