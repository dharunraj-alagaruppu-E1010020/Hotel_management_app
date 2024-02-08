class RestaurantController < ApplicationController

  before_action :create_validation,  only: [:create]
  before_action :show_validation, only: [:show]
  before_action :list_of_restaurant_validation, only: [:list_of_restaurant]
  before_action :update_validation, only: [:update]

  def index
    restaurant_details = Restaurant.all
    render json: {restaurants: restaurant_details}
  end

  def show
    render json: {restaurant: @restaurant_obj}
  end

  def list_of_restaurant
    restaurants = Restaurant.where(user_id: params[:id], is_active: true)
    render json: {restaurants: restaurants}
    # total_records = restaurants.count
    # render json: {restaurants: restaurants, count: total_records}
  end

  def create
    restaurant = Restaurant.new
    restaurant.name = params[:restaurant][:name]
    restaurant.description = params[:restaurant][:description]
    restaurant.user_id = params[:restaurant][:user_id]
    restaurant.available_start_time = params[:restaurant][:available_start_time]
    restaurant.available_end_time = params[:restaurant][:available_end_time]

    if restaurant.save
      render json: { message: 'Hotel is added your restaurant list' }, status: 201 
    else
      render json: {errors: restaurant.errors.full_messages}, status: 400
    end
  end

  def update
    @restaurant_obj.name = params[:restaurant][:name]
    @restaurant_obj.description = params[:restaurant][:description]

    if @restaurant_obj.save
      render json: { message: 'Hotel update succssfully ' }, status: 201 
    else
      render json: {errors: restaurant.errors.full_messages}, status: 400
    end
  end


  private

  def create_validation
    puts params[:restaurant][:user_id].blank?
    puts params[:restaurant][:user_id].class
    puts params[:restaurant][:name]
    if params[:restaurant][:name].blank? || params[:restaurant][:description].blank? || params[:restaurant][:user_id].blank? || params[:restaurant][:available_start_time].blank? || params[:restaurant][:available_end_time].blank?  
      render json: { message: 'Defalult field should be filled' }, status: 400
    end

    user_object = User.find_by(id: params[:restaurant][:user_id])
    if user_object.role.name != 'admin' || user_object == nil
      render json: { message: 'Admin can only add the table details' }, status: 400
    end
  end

  def index_validation
    # user_validate
    if params[:user] != 'user'
      render json: { message: 'User can only see the list of restaurant' }, status: 400
    end
  end

  def show_validation
    render json: { message: "Restaurant id or User id is missing "} if params[:id].blank? 
    @restaurant_obj = Restaurant.find(params[:id])
    render json: { message: "Admin only can edit that details"}  if @restaurant_obj == nil
  end

  def list_of_restaurant_validation
    render json: {message: 'User id is missing'} if params[:id].blank?
  end

  def update_validation
    puts params[:id].blank?
    render json: {message: 'Defalult field should be filled'} if params[:id].blank? || params[:restaurant][:name].blank? || params[:restaurant][:description].blank?
    @restaurant_obj = Restaurant.find(params[:id])
    render json: {message: 'Invalid details'} if @restaurant_obj == nil
  end

end