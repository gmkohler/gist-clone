Sequel.migration do
  change do
    create_table :comments do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      foreign_key :author_id, :users, type: :uuid, null: false
      foreign_key :gist_id, :gists, type: :uuid, null: false

      DateTime :created_at
      DateTime :updated_at

      String :body, null: false
    end

    create_table :stars do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      foreign_key :user_id, :users, type: :uuid, null: false
      foreign_key :gist_id, :gists, type: :uuid, null: false

      DateTime :created_at

      index [:user_id, :gist_id], unique: true
      index :gist_id
    end

    create_table :subscriptions do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      foreign_key :subscriber_id, :users, type: :uuid, null: false
      foreign_key :gist_id, :gists, type: :uuid, null: false

      DateTime :created_at

      index [:subscriber_id, :gist_id], unique: true
      index :gist_id
    end
  end
end
