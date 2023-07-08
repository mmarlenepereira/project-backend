class Purchase < ApplicationRecord
  belongs_to :client

  validates :description, presence: true, length: { maximum: 500 }
  validates :delivery_date, presence: true # future_date: true
end

#class Purchase < ApplicationRecord
  #belongs_to :client

  #validates :description, presence: true, length: { maximum: 500 }
  #validate :future_date_required

  #private

  #def future_date_required
   # if status != "Complete" && delivery_date.present? && delivery_date <= Date.today
    #  errors.add(:delivery_date, "Delivery date must be in the future")
   # end
  #end
#end
