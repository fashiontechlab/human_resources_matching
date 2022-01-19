class ContactMailer < ApplicationMailer

  def send_mail(schedule)
    @schedule = schedule
    mail(
      subject: "出勤依頼の通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end

  def negotiation_send_mail(schedule)
    @schedule = schedule
    mail(
      subject: "希望勤務時間の通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end

  def approval_send_mail(schedule)
    @schedule = schedule
    mail(
      subject: "勤務時間の承認の通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end

  def non_approval_send_mail(schedule)
    @schedule = schedule
    mail(
      subject: "勤務時間の非承認の通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end

  def request_delete_mail(schedule)
    @schedule = schedule
    mail(
      subject: "依頼承認の取り消し通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end

  def work_delete_mail(schedule)
    @schedule = schedule
    mail(
      subject: "依頼承認の取り消し通知です。",
      to: @schedule.human_resource.email
    ) do |format|
      format.text
    end
  end
end
