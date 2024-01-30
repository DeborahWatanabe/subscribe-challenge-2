require 'spec_helper'
require 'product.rb'

describe Product do
  describe '#total_price' do
    it 'returns the sum of price and tax for the products' do
      params = {
        name: 'product name',
        amount: 1,
        single_price: 10.0
      }

      subject = described_class.new(**params)

      expect(subject.total_price).to eq(11.0)
    end
  end

  describe '#total_tax' do
    it 'has basic tax' do
      params = {
        name: 'product name',
        amount: 1,
        single_price: 10.0
      }

      subject = described_class.new(**params)

      expect(subject.total_tax).to eq(1.0)
    end

    context 'when the product is exempt of basic tax' do
      it 'has zero tax' do
        params = {
          name: 'book',
          amount: 1,
          single_price: 10.0
        }

        subject = described_class.new(**params)

        expect(subject.total_tax).to eq(0.0)
      end
    end

    context 'when the product is imported' do
      it 'has imported duty' do
        params = {
          name: 'imported book',
          amount: 1,
          single_price: 10.0
        }

        subject = described_class.new(**params)

        expect(subject.total_tax).to eq(0.5)
      end
    end

    context 'when the tax value is a multiple of 0.05' do
      it 'returns the tax value' do
        params = {
          name: 'imported book',
          amount: 1,
          single_price: 5.0
        }

        subject = described_class.new(**params)

        expect(subject.total_tax).to eq(0.25)
      end
    end

    context 'when the tax second digit is between 1 and 4' do
      it 'returns the rounded tax' do
        params = {
          name: 'imported book',
          amount: 1,
          single_price: 2.2
        }

        subject = described_class.new(**params)

        # without rounding = 0.11
        expect(subject.total_tax).to eq(0.15)
      end
    end

    context 'when the tax second digit is between 6 and 9' do
      it 'returns the rounded tax' do
        params = {
          name: 'imported book',
          amount: 1,
          single_price: 17.4
        }

        subject = described_class.new(**params)

        # without rounding = 0.87
        expect(subject.total_tax).to eq(0.9)
      end
    end

    context 'when the tax has more than 2 digits' do
      it 'returns the rounded tax' do
        params = {
          name: 'imported book',
          amount: 1,
          single_price: 11.04
        }

        subject = described_class.new(**params)

        # without rounding = 0.552
        expect(subject.total_tax).to eq(0.6)
      end
    end

    context 'when the amount is more than 1' do
      it 'returns the total tax' do
        params = {
          name: 'imported book',
          amount: 2,
          single_price: 11.04
        }

        subject = described_class.new(**params)

        expect(subject.total_tax).to eq(1.2)
      end
    end
  end
end
