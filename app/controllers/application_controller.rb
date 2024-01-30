class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

  def user_validate
    user_id = params[:user_id]
    user_object = User.find_by(id: user_id)
    password = user_object.password
  
    if user_object == nil || password != params[:password]
      render json: { message: 'Invalid user id or password' }, status: 400
    end
  end

end
