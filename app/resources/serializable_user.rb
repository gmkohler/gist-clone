class SerializableUser < JSONAPI::Serializable::Resource
  type "users"

  attribute :handle
  attribute :display_name

  has_many :gists
end
