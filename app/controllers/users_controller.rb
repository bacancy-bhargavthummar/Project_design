class UsersController < ApplicationController

def index
    # @users = User.all
    @user = User.ransack(params[:q])
    @users_result = @user.result(distinct: true)
end 


def destroy
    user = User.find(params[:id])
    if user.destroy
        redirect_to '/users/index'
    end
end

end