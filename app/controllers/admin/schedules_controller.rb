class Admin::SchedulesController < ApplicationController

  def index
    @schedules = Schedule.where(member_id: current_member.id)
  end
end
