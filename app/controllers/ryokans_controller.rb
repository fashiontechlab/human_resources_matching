class RyokansController < ApplicationController


  def index
    @schedules = Schedule.all
    @schedules = Schedule.order("created_at DESC").page(params[:page]).per(5)
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def request_confirmation
    @schedules = Schedule.where(status: "false", ryokan_id: current_ryokan.id)
  end

  def demand_confirmation
    @schedules = Schedule.where(approval_status: "true", ryokan_id: current_ryokan.id)
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email, :status)
  end
end
