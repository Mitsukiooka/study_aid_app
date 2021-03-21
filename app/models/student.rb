class Student < ApplicationRecord
  include Enumerizable

  validates :name, presence: true
  validates :age, presence: true
  validates :primary_language, presence: true
  
  belongs_to :user
end
