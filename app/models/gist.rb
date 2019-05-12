class Gist < Sequel::Model
  plugin :many_through_many

  many_to_one :author, class: "User"
  many_to_many :revisions, class: "Revision", join_table: :gists_revisions

  one_to_many :forks, key: :forked_from_id
  many_to_many :forked_gists, class: "Gist", join_table: :forks, left_key: :forked_from_id, right_key: :forked_to_id

  one_through_many :original_gist, [[:forks, :forked_to_id, :forked_from_id]], class: "Gist"

  def validate
    super
    validates_presence :author_id
  end
end
