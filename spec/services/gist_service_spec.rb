require 'rails_helper'

RSpec.describe GistService do
  describe "::create_gist" do
    let(:private_gist) { true }
    let(:description) { "" }
    let(:author_id) { author.id }
    let(:author) { FactoryBot.create(:user) }
    let(:title) { Faker::File.file_name }

    subject(:create_gist) do
      described_class.create_gist(author_id: author_id, title: title, description: description, private_gist: private_gist)
    end

    it "creates a gist" do
      gist = nil

      expect {
        gist = create_gist
      }.to change(Gist, :count).by(1)

      expect(gist.author_id).to eql author_id
      expect(gist.description).to eql ""
      expect(gist.private_gist).to eql true
    end
  end
end
