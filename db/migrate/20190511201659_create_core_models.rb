Sequel.migration do
  up do
    run "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
    run "CREATE EXTENSION IF NOT EXISTS citext"

    create_table :users do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      DateTime :created_at

      String :password, null: false
      citext :handle, null: false

      String :display_name, null: false

      index :handle, unique: true
    end

    create_table :gists do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      foreign_key :author_id, :users, type: :uuid, null: false

      DateTime :created_at

      String :description
      Boolean :private_gist, null: false, default: true

      index :author_id
    end

    create_table :revisions do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      foreign_key :author_id, :users, type: :uuid, null: false

      DateTime :created_at

      String :diff, null: false

      index :created_at
    end

    # to support forking, we use a join table to avoid duplicating revision data
    create_table :gists_revisions do
      foreign_key :gist_id, :gists, type: :uuid, on_delete: :cascade, null: false
      foreign_key :revision_id, :revisions, type: :uuid, null: false

      primary_key [:gist_id, :revision_id]
      index [:gist_id, :revision_id]
    end

    create_table :forks do
      primary_key [:forked_from_id, :forked_to_id]
      foreign_key :forked_from_id, :gists, type: :uuid # consider cascade deletion
      foreign_key :forked_to_id, :gists, type: :uuid

      index :forked_to_id, unique: true # cannot be a fork of more than one repo
      index :forked_from_id
    end
  end

  down do
    drop_table :forks
    drop_table :gists_revisions
    drop_table :revisions
    drop_table :gists
    drop_table :users
    run "DROP EXTENSION IF EXISTS citext"
    run "DROP EXTENSION IF EXISTS \"uuid-ossp\""
  end
end
