class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:joinadmin]
  def index
    @users = User.all
  end

  def post   
  end

  def comment
  end

  def draft 
  end

  def collect
  end

  def friend
  end

  def joinadmin
    @user.join_admin
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
