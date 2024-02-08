class TableBookingController < ApplicationController

  BOOKED_STATUS = false

  before_action :validate_book_table,  only: [:book_table]
  before_action :validate_cancellation, only: [:cancel_table]

  def book_table
    table_details = TableBooking.new
    table_details.user_id = params[:user_id]
    table_details.restaurant_id = params[:restaurant_id]
    table_details.table_restaurant_id = params[:table_number]
        
    str_start_time = params[:start_time]
    str_end_time = params[:end_time]

    convert_start_time = Time.parse(str_start_time)
    convert_end_time = Time.parse(str_end_time)
      
    table_details.start_time = convert_start_time
    table_details.end_time = convert_end_time
      
    if table_details.save
      render json: { message: 'Table booked successfully' }, status: 201
    else
      render json: { errors: table_details.errors.full_messages }, status: 400
    end
  end

  def cancel_table

    @booking_obj.cancellation = true
    if @booking_obj.save
      render json: { message: 'Table successfully cancelled'}, status: 200
    else
      render json: {errors: obj.full_messages}, status: 400
    end
  end

  private
  def validate_book_table
    user_validate
    validate_input_validation
    validate_time_validation
  end

  def validate_input_validation
    if params[:restaurant_id].blank?  || params[:table_number].blank? || params[:start_time].blank? || params[:end_time].blank? || params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Please check mandatory fields'}, status: 400 
    elsif params[:start_time] >= params[:end_time]
      render json: { message: 'Invalid starting time and ending time '}, status: 400
    end
  end

  def validate_time_validation 
    start_time = Time.parse(params[:start_time]) ## 2024-01-30 09:00:00 +0530
    end_time = Time.parse(params[:end_time]) ## 2024-01-30T09:00:00+05:30 .to_datetime

    start_strftime = start_time.strftime("%H:%M:%S") ## 10:00:00
    end_strftime = end_time.strftime("%H:%M:%S")

    rest_obj = Restaurant.find_by(id: params[:restaurant_id])

    rest_start_time = rest_obj.available_start_time.strftime("%H:%M:%S") ## 2000-01-01 09:00:00 UTC , Sat, 01 Jan 2000 09:00:00.000000000 UTC +00:00
    rest_end_time = rest_obj.available_end_time.strftime("%H:%M:%S")

    is_booked = TableBooking.where(
      restaurant_id: params[:restaurant_id],
      table_restaurant_id: params[:table_number]
    )
    .where("start_time < ? AND end_time < ? AND cancellation = ?", end_time, start_time, BOOKED_STATUS).exists?
    
    if rest_start_time > start_strftime || rest_end_time < end_strftime
      render json: { message: "Check your timeline. Restaurant timeline is mismatch" }  
    elsif is_booked
      render json: { message: "This time line already booked. Can you try another time duration"}
    end
  end

  def validate_cancellation
    if params[:table_booking_id].blank? || params[:user_id].blank? || params[:password].blank?
      render json: { message: 'Please check mandatory fields'}, status: 400
    end
    user_validate

    @booking_obj = TableBooking.find_by(id: params[:table_booking_id]) 

    if @booking_obj == nil || @booking_obj.cancellation == true || @booking_obj.user_id != params[:user_id] 
       render json: { message: 'Invalid restaurant details or already cancelled'}, status: 400
    end
  end
end