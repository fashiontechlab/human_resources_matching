# coding: utf-8
class AccountsController < ApplicationController
  before_action :login_required

  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(account_params)
    if @member.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end
  #ストロングパラメータ
  private

  def account_params
    params.require(:account).permit(
      :new_profile_picture,
      :remove_profile_picture,
      :name,
      :full_name,
      :kana_name,
      :sex,
      :email
    )
  end
end

