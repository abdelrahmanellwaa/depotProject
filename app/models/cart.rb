class Cart < ApplicationRecord
	#has_many is a directieve, depenedent distroy indicates 
	#that the line items existance depends on the cart existance
	has_many :line_items, dependent: :destroy

	# to avoid adding products to new lineItem
  def add_product(product_id)
    	current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
