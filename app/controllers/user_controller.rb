class UserController < ApplicationController

    before_action :validate,  only: [:create_user]
    before_action :validate_history, only: [:history]

    def index
        user = User.all
        render json: user
    end

    def create_user
        user = User.new # Create new object for User model class
        user.name = params[:name]
        user.phone_number = params[:phone_number]
        user.password = params[:password]
        user_role = params[:role]
        role_obj = Role.find_by(role: user_role)
        user.role_id  = role_obj.id

        if user.save 
            render json: { message: 'Entry created successfully' }, status: 201
         else
            render json: { errors: user.errors.full_messages }, status: 400
        end
        
    end

    def login
        user = User.find_by(phone_number: params[:phone_number], password: params[:password])

      if user 
        if user.role_id == Role.find_by(role: 'admin')&.id
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

    private

    def validate

        if params[:name].blank? || params[:phone_number].blank? || params[:password].blank? || params[:role].blank?
          render json: { message: 'Invalid input, please check mandatory fields' }, status: 400
        end

        if !Role.is_present_role?(params[:role])
          render json: { message: 'Invalid rool, please check role fields' }, status: 400
        end

    end

    def validate_history

      if params[:user_id].blank? || params[:password].blank?
        render json: { message: 'Check mandatory fields'}, status: 400
      end

      user_id = params[:user_id]
      user_object = User.find_by(id: user_id)
      password = user_object.password

      if user_object == nil || password != params[:password]
          render json: { message: 'Invalid user id or password' }, status: 400
      end

    end
      
end