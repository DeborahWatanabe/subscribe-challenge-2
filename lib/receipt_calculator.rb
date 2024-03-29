require './product.rb'
require './receipt.rb'

class ReceiptCalculator
  def initialize
    @errors = ''
  end

  def call
    puts 'Welcome to the receipt calculator!'
    puts 'Please, input the products in the format "<amount> <product name> at <price>".'
    puts 'Input one product per row or enter a blank row to finish.'

    products = get_product_input
    receipt = Receipt.new(products:)

    puts @errors
    puts 'Your receipt:'
    puts receipt.message
  end

  private

  def get_product_input
    input = gets.chomp
    product_data = /(?<amount>\d+)\s(?<name>([a-zA-Z]+\s*)+)\sat\s(?<price>(\d+\.\d{2}))/.match(input)
  
    if input.empty?
      []
    elsif product_data.nil?
      @errors << "Item: '#{input}' could not be processed\n"
      [] + get_product_input
    else
      [
        Product.new(
          name: product_data[:name],
          amount: product_data[:amount].to_i,
          single_price: product_data[:price].to_f
        )
      ] + get_product_input
    end
  end
end

ReceiptCalculator.new.call
