class RegistrationsController < ApplicationController
  skip_before_filter :authenticate!

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t("registrations.user.success")
      redirect_to :root
    end
  end
end