if ENV["COVERAGE"]
  SimpleCov.start "rails" do
    add_filter "/spec/"
  end
end
