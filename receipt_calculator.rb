require './product.rb'

class ReceiptCalculator
  def call
    puts 'Welcome to the receipt calculator!'
    puts 'Please, input the products in the format "<amount> <product name> at <price>".'

    @products = get_product_input
    
    puts output_message
  end

  private

  def get_product_input
    puts 'Input a new product or press enter to finish.'
    input = gets.chomp
    product_data = /(?<amount>\d+)\s(?<name>([a-zA-Z]+\s*)+)\sat\s(?<price>(\d+\.\d{2}))/.match(input)
  
    if product_data.nil?
      []
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

  def output_message
    message = ''
    total_taxes = 0.0
    total = 0.0

    @products.each do |product|
      message << "#{product.amount} #{product.name}: #{format('%.2f', product.total_price)}\n"
      total_taxes += product.total_tax
      total += product.total_price
    end

    message << "Sales Taxes: #{format('%.2f', total_taxes)}\n"
    message << "Total: #{format('%.2f', total)}"
  end
end

ReceiptCalculator.new.call
