class TableRestaurantController < ApplicationController

    before_action :add_table_validation, only: [:add_table]
    before_action :list_table_available_validation, only: [:list_table_available] 

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

    def list_table_available
        tables = TableRestaurant.where(restaurant_id: params[:restaurant_id], is_active: true)
        render json: tables 
    end

    private

    def add_table_validation

        if params[:table_number].blank? || params[:no_of_chairs].blank? || params[:restaurant_id].blank?
            render json: { message: 'Recheck your mandatry fields' }, status: 400  
        end

        hotel_obj = Restaurant.find_by(id: params[:restaurant_id])

        render json: { message: 'Invalid restaurant details' }, status: 400  if hotel_obj.nil?

    end

    def list_table_available_validation

        if params[:restaurant_id].blank? || params[:user_id].blank? || params[:password].blank?
            render json: { message: 'Defalult field should be filled' }, status: 400
        end

        table = TableRestaurant.find_by(restaurant_id: params[:restaurant_id])

        if !table
            render json: { message: 'Invalid hotel details'}, status: 400
        end

        user = User.find_by(id: params[:user_id], password: params[:password])

        if !user
            render json: { message: 'Invaild user id and password' }, status: 400
        end

    end

end
