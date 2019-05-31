class User < Sequel::Model
  one_to_many :gists, key: :author_id
  one_to_many :public_gists, class: "Gist", key: :author_id, &:public

  one_to_many :comments

  one_to_many :subscriptions
  many_to_many :subscribed_gists, class: "Gist", join_table: :subscriptions, left_key: :subscriber_id, right_key: :gist_id

  one_to_many :stars
  many_to_many :starred_gists, class: "Gist", join_table: :stars, right_key: :gist_id


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
