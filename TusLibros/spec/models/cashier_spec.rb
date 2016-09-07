require 'rails_helper'

describe Cashier do
  let(:merchant_processor) { instance_spy(MerchantProcessor) }
  let(:cashier) { Cashier.new(merchant_processor) }

  context '#price_of' do
    let(:a_cart) { Cart.create! }

    subject do
      cashier.price_of(a_cart)
    end

    context 'with no books' do
      it { is_expected.to be 0 }
    end

    context 'with a 10$ book' do
      let(:a_book) { Book.create!(icbn: '123456789', title: 'The alchemist', price: 10) }

      context 'added once' do
        before { a_cart.add(a_book, 1) }
        it { is_expected.to be (10*1) }

        context 'and another book added three times' do
          let(:another_book) { Book.create!(icbn: '987654321', title: 'LOTR', price: 25) }
          before { a_cart.add(another_book, 3) }
          it { is_expected.to be (25*3+10*1) }
        end
      end
      context 'added three times' do
        before { a_cart.add(a_book, 3) }
        it { is_expected.to be (10*3) }
      end

    end
  end

  context '#charge' do
    let(:a_book) { Book.create!(icbn: '123456789', title: 'The alchemist', price: 10) }
    let(:a_cart) { Cart.create! }
    let(:a_credit_card) { nil }

    context 'with no books' do

      subject do
        cashier.charge a_cart, to: a_credit_card
      end

      it "raise error with message #{Cashier.empty_cart_error_message}" do
        expect { subject }.to raise_error RuntimeError, Cashier.empty_cart_error_message
      end
    end

    context 'with one book' do
      before do
        a_cart.add(a_book, 1)
      end
      it 'charge the right amount from the merchant processor' do
        cashier.charge a_cart, to: a_credit_card

        expect(merchant_processor).to have_received(:charge_to).with(a_credit_card, 10)
      end
    end
  end
end