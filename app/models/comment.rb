class Comment < Sequel::Model
  many_to_one :gist
  many_to_one :author, class: "User"

  def validate
    super
    validates_presence :gist_id
    validates_presence :author_id
    validates_presence :body
  end
end
