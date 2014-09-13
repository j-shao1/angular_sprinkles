require "rails_helper"

# javascript specs are slow, so test everything at
# once on a single page

feature "javascript", js: true do
  let(:name) { 'name' }
  let(:new_name) { 'namenamename?' }

  before do
    visit root_path(name: name)
  end

  it "should test all the things" do
    expect(find("#data-binding-div")).to have_content(name)
    expect(find("#bind-service-div")).to have_content("Hello #{name}")
    expect(find("#directive-div h1 h2")).to have_content(name)

    fill_in("Input", with: new_name)

    expect(find("#data-binding-div")).to have_content(new_name)
    expect(find("#bind-service-div")).to have_content("Hello #{new_name}")

    expect(find("#directive-div h1 h2")).to have_content(new_name)
  end
end