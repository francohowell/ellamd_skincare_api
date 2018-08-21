Analytics = Segment::Analytics.new(
  write_key: Figaro.env.segment_write_key!,
  on_error: proc { |_status, message| logger.info(message) },
)
