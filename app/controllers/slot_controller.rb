class SlotController < ApplicationController

  def index
    @slots = Slot.where('date=?', params[:dateslot])
  end

  def new
  end

  def create
  end
end
