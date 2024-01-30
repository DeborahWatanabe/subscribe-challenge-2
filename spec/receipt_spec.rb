require 'spec_helper'
require 'receipt.rb'
require 'product.rb'

describe Receipt do
  describe '#message' do
    it 'returns a text with receipt details' do
      products = [
        Product.new(name: 'imported bottle of perfume', amount: 1, single_price: 27.99),
        Product.new(name: 'bottle of perfume', amount: 1, single_price: 18.99),
        Product.new(name: 'packet of headache pills', amount: 1, single_price: 9.75),
        Product.new(name: 'imported box of chocolates', amount: 3, single_price: 11.25)
      ]

      subject = described_class.new(products:)

      expected_message = <<~TEXT
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported box of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      TEXT
      expect(subject.message).to eq(expected_message.chomp)
    end
  end
end
