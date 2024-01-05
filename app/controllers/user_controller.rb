class UserController < ApplicationController

    validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :phone_number, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
    validates :password, length: { minimum: 6, message: "should be at least 6 characters long" }
    validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "should include at least one letter and one digit" }

    def create_user
    #     @user = User.new(user_params)
    #   if @user.role = "admin"
    #     @user.role_id = 1
    #   else
    #     @user.role_id = 2
    #   end
    #   @user.save
    end

     
end
