module MessagesHelper
  def recipients_options
    s = ''
    user_station_id = current_user.department.station.id
    User.all.select { |user| user.department.station.id == user_station_id }.each do |user|
      s << "<option value='#{user.id}'>#{user.first_name + ' ' + user.last_name + ' ' + user.department.name + ' ' + user.department.station.name }</option>"
    end
    s.html_safe
  end
end
