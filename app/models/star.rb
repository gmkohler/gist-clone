class Star < Sequel::Model
  many_to_one :gist
  many_to_one :user

  def validate
    super
    validates_presence :gist_id
    validates_presence :user_id
    validates_unique %i(gist_id user_id)
  end
end
