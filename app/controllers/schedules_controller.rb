class SchedulesController < ApplicationController

  def index
    @schedules = Schedule.where(member_id: current_member.id)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.writer = current_member
    if @schedule.save
      redirect_to schedules_url, notice: "出勤日時を登録しました。"
    else
      render "new"
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to schedules_url,  notice: "出勤日時を編集しました。"
    else
      render "edit"
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_url,  notice: "出勤日時を削除しました。"
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start, :end, :Allday, :staff_id, :start_time, :workday, :member_id,)
  end
end
