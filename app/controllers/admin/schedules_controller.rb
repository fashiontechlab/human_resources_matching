class Admin::SchedulesController < ApplicationController

  def index
    @schedules = Schedule.all
    @schedules = Schedule.order("start_time ASC").page(params[:page]).per(100)
  end
end
