## Render this when the current user is not the user being served.
# It felt cleaner to keep the decision of which gists to serve up at the controller level,
# rather than injecting them here.
class SerializablePublicUser < SerializableUser
  has_many :gists do
    data do
      @object.public_gists
    end
  end
end
