class User < Sequel::Model
  one_to_many :gists, key: :author_id

  def validate
    super
    validates_presence :handle
    validates_presence :password
    validates_presence :display_name

    validates_unique :handle, where: (proc do |ds, user, (handle, _)|
      ds.where([[
        Sequel.function(:lower, handle), user.send(handle)&.downcase
      ]])
    end)
  end
end
