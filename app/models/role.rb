class Role < ApplicationRecord
    def self.is_present_role?(role_define)
        roles = Role.pluck(:role)  # plunk method return as a array format
        roles.include?(role_define)
    end
end
