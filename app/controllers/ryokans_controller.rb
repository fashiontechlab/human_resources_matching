class RyokansController < ApplicationController


  def index
    @schedules = Schedule.all
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def request_confirmation
    @schedules = Schedule.where(ryokan_id: current_ryokan.id)
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email, :status)
  end
end
