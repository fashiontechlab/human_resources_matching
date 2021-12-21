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
end
