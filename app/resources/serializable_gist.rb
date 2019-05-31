class SerializableGist < JSONAPI::Serializable::Resource
  type "gists"

  belongs_to :author

  attribute :private do
    @object.private_gist
  end

  attribute :title
  attribute :description
end
