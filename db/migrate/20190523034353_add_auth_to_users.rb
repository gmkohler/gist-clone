Sequel.migration do
  change do
    alter_table :users do
      add_column :authentication_token, :text, index: true, unique: true
    end

    alter_table :gists do
      add_column :title, :text, null: false
    end
  end
end
