module GistService
  def self.create_gist(author_id:, description: nil, private_gist: true)
    Sequel::Model.db.transaction do
      Gist.create(
        author_id: author_id,
        description: description,
        private_gist: private_gist
      )
    end
  end

  # todo: determine nature of "from",
  # i.e. verify that the gist's latest revision is the one trying to be applied
  def self.apply_revision(gist:, author_id:, diff:)
    Sequel::Model.db.transaction do
      revision = Revision.create(
        author_id: author_id,
        diff: diff
      )

      gist.add_revision(revision)
    end
  end

  def self.fork_gist(gist_id:, author_id:)
    Sequel::Model.db.transaction do
      original_gist = Gist[gist_id]

      forked_gist = Gist.create(
        author_id: author_id,
        description: original_gist.description,
        private_gist: original_gist.private_gist
      )

      original_gist.add_forked_gist(forked_gist)

      original_gist.revisions_dataset.order(Sequel.asc(:created_at)).all.each do |revision|
        forked_gist.add_revision(revision)
      end
    end
  end
end
