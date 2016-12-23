require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :group => nil,
      :raffled => false
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_group_id[name=?]", "event[group_id]"

      assert_select "input#event_raffled[name=?]", "event[raffled]"
    end
  end
end
