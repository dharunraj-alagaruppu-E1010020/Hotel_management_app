class RestaurantController < ApplicationController

  before_action :add_restaurant_validation,  only: [:add_restaurant]
  before_action :index_validation, only: [:index]

  def index
    restaurant_details = Restaurant.all
    render json: restaurant_details
  end
    
  def add_restaurant
    restaurant = Restaurant.new
    restaurant.name = params[:rest_name]
    restaurant.description = params[:rest_description]
    restaurant.user_id = params[:user_id]
    restaurant.available_start_time = params[:start_time]
    restaurant.available_end_time = params[:end_time]

    if restaurant.save
      render json: { message: 'Hotel is added your restaurant list' }, status: 201 
    else
      render json: {errors: restaurant.errors.full_messages}, status: 400
    end
  end

  private

  def index_validation
    user_validate
    if params[:user_id].blank? || params[:password].blank? 
      render json: { message: 'Defalult field should be filled' }, status: 400
    end
  end

  def add_restaurant_validation
    if params[:rest_name].blank? || params[:rest_description].blank? || params[:user_id].blank? || params[:password].blank? || params[:start_time].blank? || params[:end_time].blank?  
      render json: { message: 'Defalult field should be filled' }, status: 400
    end

    user_object = User.find_by(id: params[:user_id])

    if user_object.role.role != 'admin'
      render json: { message: 'Admin can only add the table details' }, status: 400
    end
  end

end
