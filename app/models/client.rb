class Client < ApplicationRecord
  has_many :purchases, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, length: { minimum: 9 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_save :update_order_count

  def order_count
    super || calculate_order_count
  end

  private

  def update_order_count
    update_column(:order_count, calculate_order_count)
  end

  def calculate_order_count
    purchases.count
  end
end
