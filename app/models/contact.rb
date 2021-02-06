class Contact < ApplicationRecord
  belongs_to :kind
  has_many :phones

  accepts_nested_attributes_for :phones, allow_destroy: true

  def as_json(options = {})
    h = super({ include: %i[kind phones] })
    h[:birthdate] = I18n.l(self.birthdate) if self.birthdate.present?
    h
  end
end
