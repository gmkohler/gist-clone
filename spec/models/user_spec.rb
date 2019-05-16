require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) { described_class.new(handle: handle, password: password, display_name: display_name) }

    let(:password) { Faker::Internet.password }
    let(:display_name) { Faker::Name.name }
    let(:handle) { Faker::Internet.username }

    context "presence" do
      let(:handle) { "" }
      let(:password) { "" }
      let(:display_name) { "" }

      it "is is invalid" do
        user.validate

        expect(user.errors[:handle]).to include "is not present"
        expect(user.errors[:display_name]).to include "is not present"
        expect(user.errors[:password]).to include "is not present"
      end
    end

    describe "case-insensitive handle uniqueness" do
      let(:handle) { Faker::Internet.username.downcase }

      context "when it is already taken (case-insensitive" do
        let!(:other_user) { FactoryBot.create(:user, handle: handle.upcase) }

        it "is invalid" do
          user.validate
          expect(user.errors[:handle]).to include "is already taken"
        end
      end
    end
  end
end
