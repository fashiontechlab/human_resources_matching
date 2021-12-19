class Admin::RyokansController < ApplicationController

  def index
    @ryokans = Ryokan.all
  end

  def new
    @ryokan = Ryokan.new
  end

  def create
    @ryokan = Ryokan.new(ryokan_params)
    if @ryokan.save
      redirect_to admin_ryokans_url, notice: "旅館のアカウントを作成しました。"
    else
      render "new"
    end
  end

  def show
    @ryokan = Ryokan.find_by(params[:id])
  end

  def edit
    @ryokan = Ryokan.find_by(params[:id])
  end

  def update
    @ryokan = Ryokan.find_by(params[:id])
    @ryokan.assign_attributes(ryokan_params)
    if @ryokan.save
      redirect_to admin_ryokans_url, notice: "アカウントを更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @schedules = Schedule.find_by(params[:id])
    @schedules.destroy
    redirect_to admin_ryokans_url, notice: "旅館のアカウントを削除しました。"
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email)

    attrs << :password if params[:action] == "create"
    params.require(:ryokan).permit(attrs)
  end
end
