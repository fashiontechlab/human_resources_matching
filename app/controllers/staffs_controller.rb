class StaffsController < ApplicationController
  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      redirect_to staffs_url, notice: "人材を登録しました。"
    else
      render "new"
    end
  end

  def show
    @staff = Staff.find(params[:id])
  end

  def edit
  end

  private

  def staff_params
    params.require(:staff).permit(:name, :kana_name, :mobile, :email, :sex)
  end
end
