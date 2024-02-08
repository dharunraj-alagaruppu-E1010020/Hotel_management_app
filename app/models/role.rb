class Role < ApplicationRecord

  has_many :users

  def self.is_present_role?(role_define)
    role_define = role_define.downcase
    roles = Role.pluck(:role)  # plunk method return as a array format
    roles.include?(role_define)
  end
  
end
