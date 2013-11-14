require 'open-uri'

class ProductsController < ApplicationController

	def index
    # products_json = open('http://lcboapi.com/products/').read
    # @products = JSON.parse(products_json)
  end

  def most_expensive_alcohol
  	expensive = Product.where("price_per_liter_of_alcohol_in_cents > 0").order(:price_per_liter_of_alcohol_in_cents)
  	expensive = expensive.where("image_thumb_url IS NOT NULL")
  	expensive = expensive.last(1)
  end

  def cheapest_alcohol
  	cheapest = Product.where("price_per_liter_of_alcohol_in_cents > 0").order(:price_per_liter_of_alcohol_in_cents)
  	cheapest = cheapest.where("image_thumb_url IS NOT NULL")
  	cheapest = cheapest.first(1)
  end

  def refresh_data
  	
  	puts "refreshing data!".bg_brown
  	
  	fetch.each do |products|
  		products['result'].each do |product|
  			
  			refresh = Product.new(
  				lcbo_id: product['id'],
					name: product['name'],
					price_in_cents: product['price_in_cents'],
					primary_category: product['primary_category'],
					secondary_category: product['secondary_category'],
					origin: product['origin'],
					price_per_liter_of_alcohol_in_cents: product['price_per_liter_of_alcohol_in_cents'],
					producer_name: product['producer_name'],
					image_thumb_url: product['image_thumb_url'],
					image_url: product['image_url']
				)

  			puts "Saving #{product['name']}!".bg_cyan

				refresh.save
  		end
  	end
  end

	def fetch
		
		@all_products = []
		end_of_list = false
		page = 1

		until end_of_list
			
			puts "Fetching page #{page}.".bg_green

			products_json = open("http://lcboapi.com/products?page=#{page}&per_page=100").read
	    products = JSON.parse(products_json)

    	@all_products << products.clone

    	puts "End of list!".bg_red if products['pager']['is_final_page']
    	end_of_list = products['pager']['is_final_page']
    	# break if products['pager']['current_page'] == 1 # safety break
    	page += 1
  	end
  	@all_products
	end

  def format_price(price_in_cents)
  	price_in_cents/100.0
  end

  helper_method :format_price, :fetch, :refresh_data, :cheapest_alcohol, :most_expensive_alcohol

end





class String
	def black;          "\033[30m#{self}\033[0m" end
	def red;            "\033[31m#{self}\033[0m" end
	def green;          "\033[32m#{self}\033[0m" end
	def  brown;         "\033[33m#{self}\033[0m" end
	def blue;           "\033[34m#{self}\033[0m" end
	def magenta;        "\033[35m#{self}\033[0m" end
	def cyan;           "\033[36m#{self}\033[0m" end
	def gray;           "\033[37m#{self}\033[0m" end
	def bg_black;       "\033[40m#{self}\0330m"  end
	def bg_red;         "\033[41m#{self}\033[0m" end
	def bg_green;       "\033[42m#{self}\033[0m" end
	def bg_brown;       "\033[43m#{self}\033[0m" end
	def bg_blue;        "\033[44m#{self}\033[0m" end
	def bg_magenta;     "\033[45m#{self}\033[0m" end
	def bg_cyan;        "\033[46m#{self}\033[0m" end
	def bg_gray;        "\033[47m#{self}\033[0m" end
	def bold;           "\033[1m#{self}\033[22m" end
	def reverse_color;  "\033[7m#{self}\033[27m" end
end