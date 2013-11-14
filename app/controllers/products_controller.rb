require 'open-uri'

class ProductsController < ApplicationController

	def index
    products_json = open('http://lcboapi.com/products/').read
    @products = JSON.parse(products_json)
  end



	private

	def find_cheapest_alcohol



	end

	def api
		@products = []
		end_of_list = false
		page = 1

		until end_of_list
			
			products_json = open("http://lcboapi.com/products?page=#{page}&per_page=50").read
	    @fetch_products = JSON.parse(products_json)

	    if @fetch_products.first[:id].nil?
	    	end_of_list = true
	    else
	    	@products << @fetch_products
	    	page += 1
	    end
  	end
  	@products
	end

  def format_price(price_in_cents)
  	price_in_cents/100.0
  end

  helper_method :format_price, :api
 
end
