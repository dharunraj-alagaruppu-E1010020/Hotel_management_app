class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :cors_set_access_control_headers
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def user_validate
    user_id = params[:user_id]
    user_object = User.find_by(id: user_id)
    password = user_object.password
  
    if user_object == nil || password != params[:password]
      render json: { message: 'Invalid user id or password' }, status: 400
    end
  end

end
