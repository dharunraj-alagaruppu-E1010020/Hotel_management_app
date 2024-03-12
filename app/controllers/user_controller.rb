class UserController < ApplicationController

  # before_action :validate_index, only: [:index]
  before_action :validate_create_user,  only: [:create_user]
  before_action :validate_login, only: [:login]
  before_action :validate_history, only: [:history]

  def index 
    page_no = 1
    split = 5
    skip_record = (page_no - 1) * split

    user = User.limit(split).offset(skip_record)
    total = User.count
    next_page = (split * page_no) < total ? true : false
    render json: { users: user , meta: {
      next_page: next_page,
      total_records: total,
      requested_page_no: page_no }}, status: 200
  end

  def create_user
    user = User.new
    user.name = params[:user][:name]
    user.phone_number = params[:user][:phone_number]
    user.password = params[:user][:password]
    user.role_id  = params[:user][:role_id]
    if user.save 
      render json: { message: 'Entry created successfully' }, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 400
    end   
  end

  def login
    if @user_obj.role.name == 'admin'
      render json: { role: 'admin' ,  user_obj: @user_obj }, status: :ok
    elsif @user_obj.role.name == 'user'
      render json: { role: 'user' , user_obj: @user_obj }, status: :ok
    end
  end

  def history
    result = TableBooking.joins(:restaurant, :table_restaurant)
    .select('restaurants.name as restaurant_name, table_restaurants.table_number as table_number, table_restaurants.no_of_chairs as number_of_chairs, table_bookings.start_time, table_bookings.end_time, table_bookings.cancellation as status')
    .where('table_bookings.user_id = ?', params[:user_id])
    .to_json
    
    render json: result
  end

  def list_of_role
    role = Role.all
    render json: {roles: role }
  end

  private

  def validate_create_user
    byebug
    if params[:user][:phone_number].blank? || params[:user][:password].blank? || params[:user][:role_id].blank?
      render json: { message: 'Invalid input, please check mandatory fields' }, status: 400
    end
    role_obj = Role.find_by(id: params[:user][:role_id])
  
    if role_obj == nil || role_obj.id != params[:user][:role_id].to_i
      render json: { message: 'Invalid role, please check role fields' }, status: 400
    end
  end

  def validate_login
    if params[:phone_number].blank? || params[:password].blank? || params[:role_id].blank?
      render json: { message: 'Invalid input, please check mandatory fields' }, status: 400
    end
    
    @user_obj = User.find_by(phone_number: params[:phone_number], password: params[:password], role_id: params[:role_id])

    if @user_obj == nil
      render json: { message: 'Please check your credentials' }, status: 400
    end
  end

  def validate_history
    user_validate
    if params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Check mandatory fields'}, status: 400
    end
  end

  def validate_index
    if params[:page_no].to_i == nil
      params[:page_no] = 1
    end
    if params[:page_no].to_i < 1
      render json: { message: "Page number start by 1"}
    end
  end

end   