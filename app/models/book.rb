class Book < ApplicationRecord
  belongs_to :user

  scope :old_books, -> { where(purchase_on: [Time.zone.today..]) }
  scope :order_purchase_on, -> { order(:purchase_on) }
  scope :order_id, -> { order(:id) }
end
