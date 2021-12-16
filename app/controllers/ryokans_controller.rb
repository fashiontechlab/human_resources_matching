class RyokansController < ApplicationController

  def index
    @schedules = Schedule.all
  end
end
