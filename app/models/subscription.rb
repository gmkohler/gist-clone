class Subscription < Sequel::Model
  many_to_one :gist
  many_to_one :subscriber, class: "User"

  def validate
    super
    validates_presence :gist_id
    validates_presence :subscriber_id
    validates_unique %i(gist_id subscriber_id)
  end
end
