require "rails_helper"

RSpec.describe "Users API" do
  describe "GET /users/:id" do
    it "returns a user" do
      user = FactoryBot.create(:user, handle: "gmkohler", display_name: "Gregory M Kohler")
      gists = FactoryBot.create_list(:gist, 2, author: user)

      jsonapi_get "/users/#{user.id}", include: "gists"

      expect(parsed_response[:data]).to match(
        {
          id: user.id,
          type: "users",
          attributes: {
            handle: "gmkohler",
            display_name: "Gregory M Kohler"
          },
          relationships: {
            gists: {
              data: match_array(gists.map { |gist| { type: "gists", id: gist.id } })
            }
          }
        }
      )
    end
  end
end
