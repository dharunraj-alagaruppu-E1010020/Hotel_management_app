class Restaurant < ApplicationRecord

    self.table_name = 'restaurants'
    belongs_to :user
end
