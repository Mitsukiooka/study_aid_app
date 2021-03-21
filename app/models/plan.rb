class Plan < ApplicationRecord
  include Enumerizable

  belongs_to :user

  def plan_status
    today = Time.zone.now.to_date
    if today < end_at
      :before_end
    else
      :after_end
    end
  end
end
