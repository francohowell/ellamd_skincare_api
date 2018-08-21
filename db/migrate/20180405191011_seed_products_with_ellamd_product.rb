class SeedProductsWithEllamdProduct < ActiveRecord::Migration[5.1]
  def change
    Product.create! store: :custom,
                    brand: "EllaMD",
                    name:  "Product"
  end
end
