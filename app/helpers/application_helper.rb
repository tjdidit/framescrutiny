module ApplicationHelper
  def format_to_ntsc(timestamp)
    if timestamp.is_a?(String)
      timestamp # Already in NTSC format
    elsif timestamp.is_a?(Integer)
      # Convert integer to NTSC format (assuming timestamp is in seconds)
      frame_rate = 24
      total_frames = timestamp * frame_rate
      hours = total_frames / (3600 * frame_rate)
      minutes = (total_frames % (3600 * frame_rate)) / (60 * frame_rate)
      seconds = (total_frames % (60 * frame_rate)) / frame_rate
      frames = total_frames % frame_rate
      format("%02d:%02d:%02d:%02d", hours, minutes, seconds, frames)
    else
      "Invalid Timestamp"
    end
  end
end