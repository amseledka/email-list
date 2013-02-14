if Capybara.current_driver == :selenium
  require 'headless'

  headless = Headless.new
  headless.start
end