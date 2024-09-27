
category = [
  {name: "Furniture"},
  {name: "Toys and hobbies"},
  {name: "Clothing"},
  {name: "Beverages"},
  {name: "Books"},
]

all_categorie = Category.create(category)

10.times do
  Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price,
    category_id: all_categorie.sample.id,
    brand: Faker::Company.name
  )
end
