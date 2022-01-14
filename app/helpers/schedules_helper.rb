module SchedulesHelper

  def profit
    @schedules = Schedule.where(work_complete_status: "true")
    @schedules.each do |schedule|
      costs = schedule.amount.to_i
      proceeds = schedule.ryokan_amount.to_i
      profit = proceeds - costs
      return profit
    end
  end
end
