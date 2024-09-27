class Product < ApplicationRecord

  belongs_to :category

  validates :name, :description, :price, :category_id, :brand, presence: true
  validates :price, numericality: true


  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
  
end
