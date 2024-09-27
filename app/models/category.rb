class Category < ApplicationRecord
  has_many :products

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end