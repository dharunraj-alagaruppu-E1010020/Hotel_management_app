class TableBookingController < ApplicationController

     before_action :validate_input_validation,  only: [:book_table]
     before_action :validate_time_validation, only: [:book_table]
    #  before_action :validate_is_before_booked, only: [:book_table]

    def book_table

        table_details =  TableBooking.new
        table_details.user_id = params[:user_id]
        table_details.restaurant_id = params[:restaurant_id]
        table_details.table_restaurant_id = params[:table_number]
        start_time_epoch = params[:start_time].to_i
        end_time_epoch = params[:end_time].to_i

        start_time_stamp = Time.at(start_time_epoch).to_datetime
        end_time_stamp = Time.at(end_time_epoch).to_datetime

        table_details.start_time = start_time_stamp
        table_details.end_time = end_time_stamp

        if table_details.save
            render json: { message: 'Table booked successfully' }, status: 201 
        else
            render json: {errors: restaurant.errors.full_messages}, status: 400
        end

    end

    private

    def validate_input_validation

        if params[:restaurant_id].blank?  || params[:table_number].blank? || params[:start_time].blank? || params[:end_time].blank? || params[:user_id].blank? || params[:password].blank?
            render json: { message: 'Please check mandatory fields'}, status: 400 
        elsif params[:start_time] >= params[:end_time]
            render json: { message: 'Invalid starting time and ending ending '}, status: 400
        end

        user_id = params[:user_id]
        user_object = User.find_by(id: user_id)
        password = user_object.password

        if user_object == nil || password != params[:password]
            render json: { message: 'Invalid user id and password' }, status: 400
        end

    end

    def validate_time_validation

        start_time_epoch = params[:start_time].to_i
        end_time_epoch = params[:end_time].to_i
      
        start_time = Time.at(start_time_epoch)
        end_time = Time.at(end_time_epoch)

        start_time_stamp = Time.at(start_time_epoch).to_datetime
        end_time_stamp = Time.at(end_time_epoch).to_datetime

        start_time = start_time.strftime("%H:%M:%S")
        end_time = end_time.strftime("%H:%M:%S")

        rest_id = params[:restaurant_id]
        rest_obj = Restaurant.find_by(id: rest_id)

        rest_start_time = rest_obj.available_start_time.strftime("%H:%M:%S")
        rest_end_time = rest_obj.available_end_time.strftime("%H:%M:%S")

        is_booked = TableBooking.where(
            restaurant_id: rest_id
          ).where("start_time < ? AND end_time > ?", end_time_stamp, start_time_stamp).exists?          

        if rest_start_time > start_time || rest_end_time < end_time
          render json: { message: "Check your timeline. Restaurant timeline is: #{rest_obj.available_start_time} to #{rest_obj.available_end_time}" }  
          elsif  is_booked
            render json: { message: "This time line already booked. Can you try another time duration"}
        end
    end
end