class SchedulesController < ApplicationController
  before_action :set_beginning_of_week

  def index
    @schedules = Schedule.where(member_id: current_member.id).order("start_time ASC").page(params[:page]).per(100)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.human_resource = current_member
    if @schedule.save(context: :check_time_axis)
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
    if @schedule.save(context: :check_time_axis)
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
    @schedule.ryokan_id = current_ryokan.id
    @schedule.status = false
    if @schedule.save
      ContactMailer.send_mail(@schedule).deliver_later
      redirect_to ryokans_url, notice: "出勤依頼のメールを送りました。"
    else
      render "confirmation"
    end
  end

  def negotiation
    @schedule = Schedule.find(params[:id])
  end

  def demand
    @schedule = Schedule.find(params[:id])
    @schedule.ryokan_id = current_ryokan.id
    @schedule.approval_status = true
    @schedule.assign_attributes(schedule_params)
    if @schedule.save(context: :check_time_axis_hope)
      ContactMailer.negotiation_send_mail(@schedule).deliver_later
      redirect_to ryokans_url, notice: "希望勤務時間のメールを送りました。"
    else
      render "negotiation"
    end
  end

  def approval_confirmation
    @schedule = Schedule.find(params[:id])
  end

  def approval
    @schedule = Schedule.find(params[:id])
    @schedule.status = false
    @schedule.approval_status = false
    @schedule.start = @schedule.hope_start
    @schedule.end = @schedule.hope_end
    @schedule.afternoon_start = @schedule.hope_afternoon_start
    @schedule.afternoon_end = @schedule.hope_afternoon_end
    @schedule.save
    ContactMailer.approval_send_mail(@schedule).deliver_later
    redirect_to schedules_url, notice: "承認のメールを送りました。"
  end

  def non_approval_confirmation
    @schedule = Schedule.find(params[:id])
  end

  def non_approval
    @schedule = Schedule.find(params[:id])
    @schedule.approval_status = false
    if @schedule.save
      ContactMailer.non_approval_send_mail(@schedule).deliver_later
      redirect_to schedules_url, notice: "非承認のメールを送りました。"
    else
      render "non_approval_confirmation"
    end
  end

  def work
    @schedules = Schedule.past_day.where(member_id: current_member.id).order("start_time ASC").page(params[:page]).per(100)
  end

  def work_delete
    @schedule = Schedule.find(params[:id])
    @schedule.status = true
    @schedule.save
    ContactMailer.work_delete_mail(@schedule).deliver_later
    redirect_to schedules_url, notice: "取り消しのメールを送りました。"
  end

  def time_card
    @schedule = Schedule.find(params[:id])
  end

  def calculation
    @schedule = Schedule.find(params[:id])
    @schedule.assign_attributes(schedule_params)
    @schedule.work_complete_status = true
    @schedule.start = @schedule.confirm_start
    @schedule.afternoon_start = @schedule.confirm_afternoon_start
    @schedule.end = @schedule.confirm_end
    @schedule.afternoon_end = @schedule.confirm_afternoon_end
    time_morning  = (@schedule.end.strftime("%H:%M")).to_f - (@schedule.start.strftime("%H:%M")).to_f
    time_afternoon = (@schedule.afternoon_end.strftime("%H:%M")).to_f - (@schedule.afternoon_start.strftime("%H:%M")).to_f
    time_total = time_morning + time_afternoon
    @schedule.amount = time_total.round * 1500
    @schedule.ryokan_amount = time_total.round * 2000
     @schedule.profit = @schedule.ryokan_amount.to_f - @schedule.amount.to_f
    if @schedule.save(context: :check_time_axis_confirm)
      redirect_to business_complete_schedules_url, notice: "タイムカードを登録しました。"
    else
      render "time_card"
    end
  end

  def business_complete
    @schedules = Schedule.where(work_complete_status: "true", member_id: current_member.id).order("start_time ASC").page(params[:page]).per(10)
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start, :end, :Allday, :staff_id, :start_time, :workday, :member_id, :ryokan_id, :status, :approval_status, :hope_start, :hope_end, :confirm_start, :confirm_end, :afternoon_start, :afternoon_end, :hope_afternoon_start, :hope_afternoon_end, :confirm_afternoon_start, :confirm_afternoon_end, :ryokan_amount, :work_complete_status, :profit)
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
