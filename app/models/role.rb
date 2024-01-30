class Role < ApplicationRecord

  has_many :user

  def self.is_present_role?(role_define)
    role_define = role_define.downcase
    roles = Role.pluck(:role)  # plunk method return as a array format
    roles.include?(role_define)
  end
  
end
