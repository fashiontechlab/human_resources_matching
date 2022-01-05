class Admin::RyokansController < ApplicationController
  before_action :set_search

  def index
    @ryokans = Ryokan.all
    @ryokans = Ryokan.order("created_at ASC").page(params[:page]).per(5)
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
    @ryokan = Ryokan.find(params[:id])
  end

  def edit
    @ryokan = Ryokan.find(params[:id])
  end

  def update
    @ryokan = Ryokan.find(params[:id])
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

  def search
    @schedules = @q.result.past_day.order()
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :password)
  end

  def set_search
    @q = Schedule.ransack(params[:q])
  end
end
