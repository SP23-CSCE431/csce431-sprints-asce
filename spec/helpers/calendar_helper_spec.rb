require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CalendarHelper. For example:
#
# describe CalendarHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe(CalendarHelper, type: :helper) do
  # describe "#month_calendar" do
  #   it "displays a calendar for a given month" do
  #     date = Date.new(2023, 3, 1)
  #     expect(helper.month_calendar(date) { |d| d.to_s }).to match(/March 2023/)
  #   end
  # end
end
