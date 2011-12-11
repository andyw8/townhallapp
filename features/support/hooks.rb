After do |scenario|
  @failure_count ||= 0
  if scenario.status == :failed
    @failure_count += 1
    save_and_open_page
    Cucumber.wants_to_quit = true if 5 == @failure_count
  end
end
