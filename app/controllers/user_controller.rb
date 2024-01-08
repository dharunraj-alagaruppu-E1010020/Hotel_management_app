class UserController < ApplicationController

    before_action :validate_name 
    before_action :validate_phone_number
    before_action :validate_password

    def index
        user = User.all
        render json: user
    end

    def create_user
        user = User.new # Create new object for User model class
        user.name = params[:name]
        user.phone_number = params[:phone_number]
        user.password = params[:password]
        type_role = params[:role] # perameter value saved into the local variable type_role

        if Role.is_present_role?(type_role) # if that class method return true that remaining processes will continue
            retrive_role_id =  Role.find_by(role: type_role)&.id
            user.role_id = retrive_role_id
        else
            raise ActiveRecord::RecordNotFound, " Undefined role : #{type_role} "
        end

        if user.save 
            render json: { message: 'Entry created successfully' }, status: :created
         else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity # 422
        end
        
    end

    def login
        user = User.find_by(phone_number: params[:phone_number])


      if user && User.find_by(password: params[:password])

        if user.role_id == Role.find_by(role: 'admin')&.id
            render json: { message: 'Admin login successful' }, status: :created
          else
            render json: { message: 'User login successful' }, status: :created
          end
      else
        render json: { message: ' Invalid phone number or password' }, status: :created
        
      end

    end

    private

    def validate_name
        rescue RuntimeError => e
         flash[:error] = e.message
         redirect_to root_path
    end

    def validate_phone_number
       rescue RuntimeError => e
        flash[:error] = e.message
        redirect_to root_path  
    end

    def validate_password
       rescue RuntimeError => e
        flash[:error] = e.message
        redirect_to root_path
    end

end
