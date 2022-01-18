class RyokansController < ApplicationController
  before_action :ryokan_login_required
  before_action :set_beginning_of_week
  before_action :set_search

  def index
    @schedules = Schedule.all
    @schedules = Schedule.past_day.order("start_time ASC").page(params[:page]).per(100)
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def request_confirmation
    @schedules = Schedule.past_day.where(status: "false", ryokan_id: current_ryokan.id).order("start_time ASC").page(params[:page]).per(10)
  end

  def request_delete
    @schedule = Schedule.find(params[:id])
    @schedule.status = true
    @schedule.save
    ContactMailer.request_delete_mail(@schedule).deliver_later
    redirect_to ryokans_url, notice: "取り消しのメールを送りました。"
  end

  def work_complete
    @schedules = Schedule.where(work_complete_status: "true", ryokan_id: current_ryokan.id).order("start_time ASC").page(params[:page]).per(10)
  end

  def name_total_expenses
    @schedule = Schedule.find(params[:id])
    get_member_id = @schedule.member_id
    @schedules = Schedule.where(work_complete_status: "true", ryokan_id: current_ryokan.id, member_id: get_member_id)
  end

  def month_total_expenses
    @schedule = Schedule.find(params[:id])
    this_month = @schedule.start_time.all_month
    @schedules = Schedule.where(work_complete_status: "true", ryokan_id: current_ryokan.id, start_time: this_month)
  end

  def demand_confirmation
    @schedules = Schedule.where(approval_status: "true", ryokan_id: current_ryokan.id).order("start_time ASC").page(params[:page]).per(10)
  end

  def ryokan_login_required
    raise Forbidden unless current_ryokan
  end

  def search
    @schedules = @q.result.past_day.order("start_time ASC").page(params[:page]).per(10)
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email, :status)
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def set_search
    @q = Schedule.ransack(params[:q])
  end
end
