class SchedulesController < ApplicationController

  def index
    @schedules =  Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to schedules_url, notice: "出勤日時を登録しました。"
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start, :end, :Allday, :staff_id, :start_time, :workday)
  end
end
