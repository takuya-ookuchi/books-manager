# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: "「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "「#{@user.name}」を削除しました。"
  end

  def update
    @user.update!(user_params)
    redirect_to users_url, notice: "「#{@user.name}」の登録情報を更新しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :furigana)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
