class UsersController < ApplicationController
  def edit
  end

  def update
  end

  private 

  def user_params
    params.require(:user).permit(:line_user_id, :prefecture_id)
  end
end
