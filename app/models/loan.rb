class Loan < ApplicationRecord
  belongs_to :profile
  belongs_to :loan_type

  has_many :loan_repayments, dependent: :destroy
  accepts_nested_attributes_for :loan_repayments

  validates :amount, presence: true
  validates :duration, presence: true
  validates :yearly_deduction, presence: true
  validates :monthly_deduction, presence: true
  validates :expected_amount, presence: true
  validates :loan_type_id, presence: true
  validates :profile, presence: true
  validates :guarantor_one_id, presence: true
  validates :guarantor_two_id, presence: true

  enum status: [:rejected, :pending, :approved], _suffix: true
  enum guarantor_one_status: [:rejected, :pending, :approved], _suffix: true
  enum guarantor_two_status: [:rejected, :pending, :approved], _suffix: true
end
