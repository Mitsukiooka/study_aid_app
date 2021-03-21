class Plan < ApplicationRecord
  include Enumerizable

  belongs_to :user
end
