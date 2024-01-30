class TableRestaurantController < ApplicationController
  before_action :validate, only: [:index] 
  before_action :add_table_validation, only: [:add_table]
 
  def index
    tables = TableRestaurant.where(restaurant_id: params[:restaurant_id], is_active: true)
    render json: tables 
  end

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

  def validate
    if params[:restaurant_id].blank? || params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Defalult field should be filled' }, status: 400
    end

    user_validate
    restaurant = Restaurant.find_by(id: params[:restaurant_id])

    if restaurant == nil
      render json: { message: 'Invalid restaurant details'}, status: 400
    end
  end

  def add_table_validation
    if params[:table_number].blank? || params[:no_of_chairs].blank? || params[:restaurant_id].blank? || params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Recheck your mandatry fields' }, status: 400  
    end
    
    user_validate
    hotel_obj = Restaurant.find_by(id: params[:restaurant_id])
    render json: { message: 'Invalid restaurant details' }, status: 400  if hotel_obj.nil?
    render json: { message: 'Admin details mismatch' }, status: 400  if hotel_obj.user.id != params[:user_id]
  end

end
