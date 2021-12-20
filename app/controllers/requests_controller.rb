class RequestsController < ApplicationController

  def new
  end

  def create
  end

  def confirmation
    @schedule = Schedule.find(params[:id])
    @schedule
  end

  def destroy
  end
end
