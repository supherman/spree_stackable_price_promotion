require 'spec_helper'

describe Spree::Calculator::StackablePriceSack do
  describe '#compute' do
    let(:item1) { double('item', amount: 500) }
    let(:item2) { double('item', amount: 1200) }

    before do
      subject.preferred_limit_amount = 500
      subject.preferred_discount_amount = 100
    end

    context 'An array' do
      it 'sums the given discount every given amount' do
        expect(subject.compute([item1, item2])).to eq 300
      end
    end

    context 'A single object' do
      it 'sums the given discount every given amount' do
        expect(subject.compute(item1)).to eq 100
        expect(subject.compute(item2)).to eq 200
      end
    end

    context 'zero min amount' do
      before do
        subject.preferred_limit_amount = 0
        subject.preferred_discount_amount = 100
      end

      it 'returns the preferred discount amount' do
        expect(subject.compute(item1)).to eq 100
      end
    end
  end
end
