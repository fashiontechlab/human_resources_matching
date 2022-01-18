class Admin::SchedulesController < ApplicationController
  before_action :set_search

  def index
    @schedules = Schedule.all
    @schedules = Schedule.order("start_time ASC").page(params[:page]).per(100)
  end

  def search
    @schedules = @q.result.past_day.order("start_time ASC").page(params[:page]).per(5)
  end

  def work
    @schedules = Schedule.all
  end

  def business_complete
    @schedules = Schedule.all
  end

  def set_search
    @q = Schedule.ransack(params[:q])
  end

  def name_total_expenses
    @schedule = Schedule.find(params[:id])
    get_member_id = @schedule.member_id
    @schedules = Schedule.where(work_complete_status: "true", member_id: get_member_id)
  end

  def user_month_total_expenses
    @schedule = Schedule.find(params[:id])
    this_month = @schedule.start_time.all_month
    @schedules = Schedule.where(work_complete_status: "true", start_time: this_month).order("start_time ASC").page(params[:page]).per(10)
  end

  def ryokan_total_expenses
    @schedule = Schedule.find(params[:id])
    get_ryokan_id = @schedule.ryokan_id
    @schedules = Schedule.where(work_complete_status: "true", ryokan_id: get_ryokan_id)
  end
end
