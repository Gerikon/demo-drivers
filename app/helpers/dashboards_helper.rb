module DashboardsHelper
  def formatted_duration(seconds)
    hours   = (seconds / (60 * 60)).floor.to_s.rjust(2, '0')
    minutes = ((seconds / 60) % 60).floor.to_s.rjust(2, '0')

    "#{hours}:#{minutes}"
  end
end