class UserController < ApplicationController

  before_action :validate_index, only: [:index]
  before_action :validate,  only: [:create_user]
  before_action :user_validate, only: [:login]
  before_action :validate_history, only: [:history]
  
  def index
    page_no = params[:page_no]
    split = 2
    skip_record = (page_no - 1) * split

    user = User.limit(split).offset(skip_record)
    total = User.count
    next_page = (split * page_no) < total ? true : false

    render json: { data: user , meta: {
      next_page: next_page,
      total_records: total,
      requested_page_no: page_no }} 
  end

  def create_user
    user = User.new
    user.name = params[:name]
    user.phone_number = params[:phone_number]
    user.password = params[:password]
    user.role_id  = params[:role_id]

    if user.save 
      render json: { message: 'Entry created successfully' }, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 400
    end   
  end

  def login
    user = User.find_by(phone_number: params[:phone_number], password: params[:password])
    if user
      if user.role.role == 'admin'
        render json: { message: 'Admin login successful' }, status: :ok
      else
        render json: { message: 'User login successful' }, status: :ok
      end
    else
      render json: { message: ' Invalid phone number or password' }, status: :unprocessable_entity
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
    render json: { roles: role }
  end

  private

  def validate
    if params[:phone_number].blank? || params[:password].blank? || params[:role_id].blank?
      render json: { message: 'Invalid input, please check mandatory fields' }, status: 400
    end
    role_exists = Role.find_by(id: params[:role_id])
    if role_exists == nil
      render json: { message: 'Invalid role, please check role fields' }, status: 400
    end
  end

  def validate_history
    user_validate
    if params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Check mandatory fields'}, status: 400
    end
  end

  def validate_index
    if params[:page_no] < 1
      render json: { message: "Page number start by 1"}
    end
  end
      
end