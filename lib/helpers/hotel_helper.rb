require_relative '../models/hotel'

module HotelHelper
  def self.find_cheapest_hotel(customer_type, dates)
    min = nil
    cheapest_hotel = nil

    hotels.each_with_index do |hotel, index|
      total =
        dates.map do |date|
          hotel.price(customer_type, date)
        end.reduce(&:+)

      if
        min.nil? ||
        total < min ||
        total == min &&
        hotel.rating > cheapest_hotel.rating
      then
        min = total
        cheapest_hotel = hotel
      end
    end

    cheapest_hotel
  end

  def self.register_hotel(hotel)
    hotels.include?(hotel) || hotels << hotel
    self
  end

  private

  def self.hotels
    @hotels ||= []
  end
end