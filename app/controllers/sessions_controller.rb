# coding: utf-8
class SessionsController < ApplicationController
  def create
    ryokan = Ryokan.find_by(name: params[:name])
    if ryokan&.authenticate(params[:password])
      session[:ryokan_id] = ryokan.id
    else
      flash.alert = "名前とパスワードが一致しません。"
    end
    redirect_to :root
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end

