class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :user, optional: true

  enum :status, [:in_cart, :checkout]
end
