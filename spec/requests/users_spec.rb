require "rails_helper"

RSpec.describe "Users API" do
  describe "GET /users/:id" do
    let(:user) { FactoryBot.create(:user, handle: "gmkohler", display_name: "Gregory M Kohler") }

    it "returns a user" do
      jsonapi_get "/users/#{user.id}", {}, { Authorization: "Token token=\"#{user.authentication_token}\"" }

      expect(parsed_response[:data]).to match({
        id: user.id,
        type: "users",
        attributes: {
          handle: "gmkohler",
          display_name: "Gregory M Kohler"
        },
        relationships: {
          gists: {
            meta: {
              included: false
            }
          }
        }
      })
    end

    context "when gists are requested" do
      let!(:private_gist) { FactoryBot.create(:gist, author: user) }
      let!(:public_gist) { FactoryBot.create(:gist, :public, author: user) }

      subject(:get_user_with_gists) do
        jsonapi_get "/users/#{user.id}", { include: "gists" }, { Authorization: "Token token=\"#{authentication_token}\"" }
      end

      context "when the auth header includes the requested user's auth token" do
        let(:authentication_token) { user.authentication_token }

        it "includes private gists" do
          get_user_with_gists

          expect(parsed_response[:included]).to match_array [
            match(
              id: public_gist.id,
              type: "gists",
              attributes: {
                description: be_present,
                title: be_present,
                private: false
              }
            ),
            match(
              id: private_gist.id,
              type: "gists",
              attributes: {
                description: be_present,
                title: be_present,
                private: true
              }
            )
          ]
        end
      end

      context "when the auth header includes some other value" do
        let(:authentication_token) { SecureRandom.hex }

        it "omits private gists" do
          get_user_with_gists

          expect(parsed_response[:included]).to match_array [
            match(
              id: public_gist.id,
              type: "gists",
              attributes: {
                description: be_present,
                title: be_present,
                private: false
              }
            )
          ]
        end
      end
    end
  end
end
