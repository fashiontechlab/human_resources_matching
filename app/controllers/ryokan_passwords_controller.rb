class RyokanPasswordsController < ApplicationController

  def show
  end

  def edit
    @ryokan = current_ryokan
  end

  def update
    @ryokan = current_ryokan
    current_ryokan_password = account_ryokan_params[:current_ryokan_password]

    if current_ryokan_password.present?
      if @ryokan.authenticate(current_ryokan_password)
        @ryokan.assign_attributes(account_ryokan_params)
        if @ryokan.save
          redirect_to :ryokan_account, notice: "パスワードを変更しました。"
        else
          render "edit"
        end
      else
        @ryokan.errors.add(:current_ryokan_password, :wrong)
        render "edit"
      end
    else
      @ryokan.errors.add(:current_ryokan_password, :empty)
      render "edit"
    end
  end

  private

  def account_ryokan_params
    params.require(:ryokan).permit(
      :current_ryokan_password,
      :password,
      :password_confirmation
    )
  end
end
