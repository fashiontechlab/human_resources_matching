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
end
