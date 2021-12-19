class RyokansController < ApplicationController
  before_action :login_required

  def index
    @schedules = Schedule.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def ryokan_params
    params.require(:ryokan).permit(:name, :full_name, :kana_name, :email, :manager, :telephone, :email)
  end
end
