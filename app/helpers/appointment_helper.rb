module AppointmentHelper
  def good_and_bad_appointments
    good = []
    bad = []
    
    array = current_user.appointments

    array.each do |each|
      if Slot.find(each.slot_id).availability == false
        bad << each
      else
        good << each
      end
    end
    [good, bad]
  end
end
