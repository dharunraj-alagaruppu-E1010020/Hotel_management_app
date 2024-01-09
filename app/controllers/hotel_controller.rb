class HotelController < ApplicationController

    before_action :input_validation,  only: [:add_hotel]

    def add_hotel
        hotel = Hotel.new
        hotel.name = params[:hotel_name]
        hotel.description = params[:hotel_description]
        hotel.user_id = params[:user_id]

        if hotel.save
            render json: { message: 'Hotel is added your hotel list' }, status: created 
        else
            render json: {errors: hotel.errors.full_messages}, status: 400
        end
    end

    private
    def input_validation
        if params[:hotel_name].blank? || params[:hotel_description].blank? || params[:user_id].blank?
            render json: { message: 'Defalult field should be filled' }, status: 400
        end

        user_id = params[:user_id]
        user_object = User.find_by(id: user_id)
        role = user_object.role.role

        if role != 'admin'
           render json: { message: 'Admin can only add the hotel details' }, status: 400
        end
    end
end
