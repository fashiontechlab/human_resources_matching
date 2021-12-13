class SchedulesController < ApplicationController

  def index
    @schedules =  Schedule.new
  end
end
