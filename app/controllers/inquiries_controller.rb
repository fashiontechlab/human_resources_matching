class InquiriesController < ApplicationController

  def index
    @inquiries = Inquiries.all
  end
end
