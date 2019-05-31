class UsersController < ApplicationController
  def show
    user = User[params[:id]]

    return head :not_found if user.nil?

    user_resource = user.id == current_user&.id \
      ? SerializableUser \
      : SerializablePublicUser

    render \
      jsonapi: user,
      class: jsonapi_class.merge!(User: user_resource),
      fields: {
        user: %i( display_name handle ),
        gists: %i( description private title )
      }
  end
end
