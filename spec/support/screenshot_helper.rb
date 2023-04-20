module ScreenshotHelper
  # I only want these recorded if CAPTURE is on, otherwise run as normal
  def potentially_screenshot(path, add_timestamp: true)
    return unless ENV['CAPTURE'] == '1'

    *directory, file_name = path.split('/')

    # Lazy, probably
    file_name = "#{file_name}.png" unless file_name.end_with?('.png')

    if add_timestamp
      timestamp = Time.now.strftime('%F-%H-%M')
      file_name = "#{timestamp}_#{file_name}"
    end

    save_screenshot [*directory, file_name].join('/')
  end
end

RSpec.configure { _1.include ScreenshotHelper, type: :feature }
