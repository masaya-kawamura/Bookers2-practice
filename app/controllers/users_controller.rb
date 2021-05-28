class UsersController < ApplicationController
  # ユーザーがcurrent_userと同じじゃなかったらリダイレクト
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  #フォロー一覧ページ
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render '_show_follow'
  end

  # フォロワー一覧ページ
  def followers
    @title = "Follower"
    @user = User.find(params[:id])
    @users = @user.followers
    render '_show_follow'
  end


    private

    def ensure_correct_user
      @user = User.find(params[:id])
      if @user.id != current_user.id
        redirect_to user_path(current_user.id)
      end
    end

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
