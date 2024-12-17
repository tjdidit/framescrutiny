module RevisionsHelper
  def format_to_ntsc(time_in_seconds, frame_rate = 24)
    total_frames = (time_in_seconds.to_f * frame_rate).round
    hours = total_frames / (3600 * frame_rate)
    minutes = (total_frames % (3600 * frame_rate)) / (60 * frame_rate)
    seconds = (total_frames % (60 * frame_rate)) / frame_rate
    frames = total_frames % frame_rate

    format('%02d:%02d:%02d:%02d', hours, minutes, seconds, frames)
  end
end