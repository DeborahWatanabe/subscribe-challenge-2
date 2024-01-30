class Receipt
  def initialize(products:)
    @products = products
    @total_taxes = 0.0
    @total = 0.0
  end

  def message
    @message ||= generate_message
  end

  private

  def generate_message
    message = products_list
    message << "Sales Taxes: #{format('%.2f', @total_taxes)}\n"
    message << "Total: #{format('%.2f', @total)}"
  end

  def products_list
    @products.reduce('') do |result, product|
      @total_taxes += product.total_tax
      @total += product.total_price

      result << "#{product.amount} #{product.name}: #{format('%.2f', product.total_price)}\n"
    end
  end
end
