require 'rails_helper'

RSpec.describe Gist, type: :model do
  describe "validations" do
    let(:author) { FactoryBot.create(:user) }
    let(:gist) { described_class.new(author: author) }

    describe "presence" do
      let(:author) { nil }

      it "requires an author" do
        gist.validate
        expect(gist.errors[:author_id]).to include "is not present"
      end
    end
  end
end
