require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

test "product attributes must not be empty" do 
	product = Product.new
	assert product.invalid?
	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
end

test "product price must be positive" do
	product = Product.new(title: "My Book Title",
	description: "yyy", image_url: "zzz.jpg")
	product.price = -1
	assert product.invalid?

	#verify the error message associated with the price attribute is what we expect.
	assert_equal ["must be greater than or equal to 0.01"],
    	product.errors[:price]
	product.price = 0
	assert product.invalid?
	assert_equal ["must be greater than or equal to 0.01"],
    	product.errors[:price]
  	product.price = 1
  	assert product.valid?
end

test "image url" do
	# an abbreviation for an array of strings
	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
	bad = %w{ fred.doc fred.gif/more fred.gif.more }
	ok.each do |name|
		assert new_product(name).valid?, "#{name} should be valid"
	end
	bad.each do |name|
		assert new_product(name).invalid?, "#{name} shouldn't be valid" 
	end
end


# this is a directive directive loads the fixture data corresponding 
#to the given model name into the corresponding database table before each 
#test method in the test case is run. in products.yml
# works on an independent test db
#fixtures :products by default

test "product is not valid without a unique title" do
	#before creating on object, it checks the test db 
	product = Product.new(title: products(:ruby).title,
			description: "yyy", 
			price: 1, 
			image_url: "fred.gif")
  	assert product.invalid?
	assert_equal ["has already been taken"], 
	product.errors[:title] 
end



private
	def new_product(image_url) 
		Product.new(title: "My Book Title",
		description: "yyy", price: 1, image_url: image_url)
	end

end