class Revision < Sequel::Model
  many_to_one :author
  many_to_many :gists, join_table: :gists_revisions

  def dataset_module
    def chronological
      order(Sequel.asc(:created_at))
    end

    def reverse_chronological
      order(Sequel.desc(:created_at))
    end
  end

  def validate
    super
    validates_presence :author_id
    validates_presence :diff
  end
end
