require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :name => "MyString",
      :group => nil,
      :raffled => false
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_group_id[name=?]", "event[group_id]"

      assert_select "input#event_raffled[name=?]", "event[raffled]"
    end
  end
end
