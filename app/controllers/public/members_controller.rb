class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def follows
  end

  def edit
  end

  def update

  end

  def email_edit
  end

  def email_update

  end

  def password_edit
  end

  def password_update

  end
end
