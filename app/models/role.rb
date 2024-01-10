class Role < ApplicationRecord

    has_many :user

    def self.is_present_role?(role_define)
        role_define = role_define.downcase
        roles = Role.pluck(:role)  # plunk method return as a array format
        roles.include?(role_define)
    end

    # def self.check_role(user_id)
    #     user_object = User.find_by(id: user_id)
      
    #     if user_object
    #       return user_object.role.role
    #     end
    # end

end
