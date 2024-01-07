class UserController < ApplicationController

    def index
        render :index 
    end

    def create_user

        @user = User.new # Create new object for User model class
        @user.name = params[:name]
        @user.phone_number = params[:phone_number]
        @user.password = params[:password]
        type_role = params[:role] # perameter value saved into the local variable type_role

        if Role.is_present_role?(type_role) # if that class method return true that remaining processes will continue
            retrive_role_id =  Role.find_by(role: type_role)&.id
            @user.role_id = retrive_role_id
         render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity # throw new exception standard error 
        end

        if @user.save 
            render json: { message: 'Entry created successfully' }, status: :created
            return # Because AbstractController::DoubleRenderError in UserController#create_user is accour
         else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            return 
        end
        
    end

end
