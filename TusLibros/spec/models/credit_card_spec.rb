require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'a credit card with an invalid number can not be created' do
    subject do
      build(:credit_card)
    end

    it { is_expected.to be_valid }
  end

  context 'a credit card with an invalid number can not be created' do
    subject do
      build(:credit_card, number: '1234')
    end

    it { is_expected.not_to be_valid }
  end

  context 'a credit card with an invalid number can not be created' do
    subject do
      build(:credit_card, number: 'j' * 16)
    end

    it { is_expected.not_to be_valid }
  end

  context 'a credit card with an expired date can not be created' do
    subject do
      build(:credit_card, expiration_date: 7.days.ago)
    end

    it { is_expected.not_to be_valid }
  end
end
