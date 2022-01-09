# coding: utf-8
class Admin::MembersController < Admin::Base


  #会員一覧
  def index
    @members = Member.order(:name)
                 .page(params[:page]).per(7)
  end
  #会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end
  #新規フォーム
  def new
    @member = Member.new
  end
  #更新フォーム
  def edit
    @member = Member.find(params[:id])
  end
  #会員の新規登録
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to [:admin, @member],notice: "メンバーを登録しました。"
    else
      render "new"
    end
  end
  #会員情報の更新
  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to [:admin, @member], notice: "メンバー情報を更新しました。"
    else
      render "edit"
    end
  end
  #会員の削除
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members , notice: "メンバーを削除しました。"
  end

  #検索
  def search
    @members = Member.search(params[:q])
                 .page(params[:page]).per(15)
    render "index"
  end

  #ストロングパラメータ
  private

  def member_params
    attrs = [
      :new_profile_picture,
      :remove_profile_picture,
      :name,
      :full_name,
      :kana_name,
      :sex,
      :email,
      :mobile,
      :administrator
    ]

    attrs << :password if params[:action] == "create"

    params.require(:member).permit(attrs)
  end
end
