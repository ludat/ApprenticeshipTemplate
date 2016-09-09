class CreditCard < ActiveRecord::Base
  belongs_to :user

  validates :number, format: {with: /\A[0-9]{16}\z/,
                              message: 'Invalid credit card'}

  validate :expiration_date_is_after_now

  def expiration_date_is_after_now
    errors.add(:expiration_date, "The credit card has already expired") if expiration_date < Time.now
  end
end
