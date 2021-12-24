class SchedulesController < ApplicationController

  def index
    @schedules = Schedule.where(member_id: current_member.id)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.human_resource = current_member
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
    @schedule.assign_attributes(schedule_params)
    if @schedule.save
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

  def confirmation
    @schedule = Schedule.find(params[:id])
  end

  def ask
    @schedule = Schedule.find(params[:id])
    if ContactMailer.send_mail(@schedule).deliver_later
      redirect_to ryokans_url, notice: "出勤依頼のメールを送りました。"
      @schedule.status = false
      @schedule.save
    else
      render "ask"
    end
  end

  def negotiation
    @schedule = Schedule.find(params[:id])
  end

  def demand
    @schedule = Schedule.find(params[:id])
    if @schedule.assign_attributes(schedule_params)
      @schedule.approval_status == true
      @schedule.save
    else
      @schedule.assign_attributes(schedule_params)
      ContactMailer.negotiation_send_mail(@schedule).deliver_later
      redirect_to ryokans_url, notice: "希望勤務時間のメールを送りました。"
    end
  end

  def approval_confirmation
    @schedule = Schedule.find(params[:id])
  end

  def approval
    @schedule = Schedule.find(params[:id])
    @schedule.assign_attributes(schedule_params)
    ContactMailer.approval_send_mail(@schedule).deliver_later
    redirect_to schedules_url, notice: "承認のメールを送りました。"
    @schedule.approval_status = true
    @schedule.save
  end

  def non_approval_confirmation
    @schedule = Schedule.find(params[:id])
  end

  def non_approval
    @schedule = Schedule.find(params[:id])
    ContactMailer.non_approval_send_mail(@schedule).deliver_later
    redirect_to schedules_url, notice: "非承認のメールを送りました。"
  end


  private

  def schedule_params
    params.require(:schedule).permit(:start, :end, :Allday, :staff_id, :start_time, :workday, :member_id, :status, :approval_status)
  end
end
