class RyokanAccountsController < ApplicationController

  def edit
    @ryokan = current_ryokan
  end

  def show
    @ryokan = current_ryokan
  end

  def update
    @ryokan = current_ryokan
    @ryokan.assign_attributes(ryokan_account_params)
    if @ryokan.save
      redirect_to :ryokan_account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  private

  def ryokan_account_params
    params.require(:ryokan).permit(
      :name,
      :full_name,
      :kana_name,
      :manager,
      :email,
      :telephone
    )
  end
end
