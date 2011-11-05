After do |scenario|
  if scenario.status == :failed
    save_and_open_page
    Cucumber.wants_to_quit = true
  end
end
