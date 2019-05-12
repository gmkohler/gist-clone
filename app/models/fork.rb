class Fork < Sequel::Model
  many_to_one :gist, key: :forked_from_id
  one_to_one :forked_gist, key: :forked_to_id
end
