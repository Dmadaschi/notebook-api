class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do
    link(:kind) { kind_url(object.kind.id) }
  end
  has_one :address
  has_many :phones

  link(:self) { contact_url(object.id) }

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
