class RyokansController < ApplicationController

  def index
    @schedules = Schedule.all
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email)
  end
end
