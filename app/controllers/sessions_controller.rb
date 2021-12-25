# coding: utf-8
class SessionsController < ApplicationController
  def create
    member = Member.find_by(name: params[:name])
    ryokan = Ryokan.find_by(name: params[:name])
    if member&.authenticate(params[:password]) || ryokan&.authenticate(params[:password])
      session[:member_id] = member.id || session[:ryokan_id] = ryokan.id
    else
      flash.alert = "名前とパスワードが一致しません。"
    end
    redirect_to :root
  end

  def destroy
    if session.delete(:member_id)
    else
      session.delete(:ryokan_id)
    end
    redirect_to :root
  end
end

