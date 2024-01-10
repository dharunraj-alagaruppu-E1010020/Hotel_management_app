class TableRestaurantController < ApplicationController

    before_action :input_validation, only: :add_table

    def add_table
        table = TableRestaurant.new
        table.table_number = params[:table_number]
        table.no_of_chairs = params[:no_of_chairs]
        table.restaurant_id = params[:restaurant_id]

        if table.save
            render json: { message: 'Table added successfully' }, status: 201
        else
            render json: { errors: table.errors.full_messages }, status: 400
        end
    end

    private

    def input_validation

        if params[:table_number].blank? || params[:no_of_chairs].blank? || params[:restaurant_id].blank?
            render json: { message: 'Recheck your mandatry fields' }, status: 400  
        end

        hotel_obj = Restaurant.find_by(id: params[:restaurant_id])

        render json: { message: 'Invalid restaurant details' }, status: 400  if hotel_obj.nil?

    end

end
