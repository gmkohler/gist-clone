class UsersController < ApplicationController
  def show
    user = User[params[:id]]

    if user.nil?
      head :not_found
    else
      render \
        jsonapi: user,
        fields: { user: [:handle, :display_name] }
    end
  end
end
