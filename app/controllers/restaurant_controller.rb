class RestaurantController < ApplicationController

    before_action :input_validation,  only: [:add_restaurant]

    def add_restaurant
        restaurant = Restaurant.new
        restaurant.name = params[:name]
        restaurant.description = params[:description]
        restaurant.user_id = params[:user_id]

        if restaurant.save
            render json: { message: 'Hotel is added your restaurant list' }, status: 201 
        else
            render json: {errors: restaurant.errors.full_messages}, status: 400
        end
    end

    private
    def input_validation
        if params[:name].blank? || params[:description].blank? || params[:user_id].blank?
            render json: { message: 'Defalult field should be filled' }, status: 400
        end

        user_id = params[:user_id]
        user_object = User.find_by(id: user_id)
        role = user_object.role.role

        if role != 'admin'
           render json: { message: 'Admin can only add the restaurant details' }, status: 400
        end
    end
end
