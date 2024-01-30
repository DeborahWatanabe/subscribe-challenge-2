class Product
  EXEMPT_PRODUCTS = [
    'book', 'chocolate bar', 'box of chocolates', 'packet of headache pills', 'boxes of chocolates'
  ].freeze
  BASIC_TAX = 0.1
  IMPORT_DUTY = 0.05

  def initialize(name:, amount:, single_price:)
    @name = name
    @amount = amount
    @single_price = single_price
  end

  attr_accessor :name, :amount

  def total_price
    @total_price ||= @single_price * @amount + total_tax
  end

  def total_tax
    @total_tax ||= rounded_tax * @amount
  end

  private
    
  def tax_rate
    imported_product = /imported\s(?<name>([a-z]+\s*)+)/.match(@name)
    product_name = imported_product ? imported_product[:name] : @name

    tax = 0
    tax += IMPORT_DUTY if !!imported_product
    tax += BASIC_TAX unless EXEMPT_PRODUCTS.include?(product_name)

    tax
  end

  def rounded_tax
    tax_value = tax_rate * @single_price
    two_digit_tax = tax_value.ceil(2)
    last_digit = format('%.2f', two_digit_tax)[-1].to_i
    remainder = last_digit % 5

    (remainder.zero? ? two_digit_tax : two_digit_tax - (remainder * 0.01) + IMPORT_DUTY).round(2)
  end
end
