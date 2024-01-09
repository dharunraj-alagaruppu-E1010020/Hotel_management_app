class UserController < ApplicationController

    before_action :validate_name 
    before_action :validate_phone_number
    before_action :validate_password

    def index
        user = User.all
        render json: user
    end

    def create_user
        @user = User.new(user_params)
        
    end

     
end
