class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:related) { v1_contact_kind_url(object.id) }
  end
  has_one :address do
    link(:related) { v1_contact_address_url(object.id) }
  end
  has_many :phones do
    link(:related) { v1_contact_phones_url(object.id) }
  end

  meta do
    {
      author: 'Daniel Madaschi'
    }
  end

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = object.birthdate.to_time.iso8601 if object.birthdate.present?
    h
  end
end
