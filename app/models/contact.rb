class Contact < ApplicationRecord
  belongs_to :kind
  has_one :address
  has_many :phones

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options = {})
    h = super({ include: %i[kind phones address] })
    h[:birthdate] = I18n.l(self.birthdate) if self.birthdate.present?
    h
  end
end
