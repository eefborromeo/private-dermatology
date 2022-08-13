class SlotController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :is_admin, only: [:new, :create]
  before_action :check_user_info, if: :user_signed_in?

  def index
    @slots = Slot.where("date=?", params[:dateslot])
  end
  
  def new
    @slot = Slot.new
  end

  def create
    @slot = Slot.new(slot_params)

    if @slot.save
      redirect_to slot_index_path,  notice: 'The slot has been created.'
    else
      render :new, alert: @slot.errors.first.full_message
    end
  end

  private
  def set_slot
    @slot = Slot.find(params[:id])
  end

  def slot_params
    params.require(:slot).permit(:id, :date, :time, :availability, :interaction)
  end
end
