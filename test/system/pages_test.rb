require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  def setup
    @user = users :maria
    login_as @user

    @office = offices :hundertland

    # visit homeage as a logged in user
    visit root_path
  end

  test "testing content: office section and cards" do
    # check if office section and cards exist
    assert_selector "h2", text: "Offices"
    assert_selector ".card-list", count: Office.count
    assert page.has_content?(@office.name)
  end

  test "testing feature: create an office" do
    # visit office index page
    click_on 'Offices'

    # add an office
    click_on 'Create an office', match: :prefer_exact

    # ill out the form and submit a new office
    fill_in "office_name", with: "Awesome Office"
    fill_in "office_url", with: "www.awesome-office.com"
    fill_in "office_location", with: "Warschauer Str. 41, 10243 Berlin"

    click_on 'Create office', match: :prefer_exact
    # find('input[name="commit"]').click

    save_and_open_screenshot

    assert_current_path office_path(Office.last)
    assert page.has_content?("Awesome Office")
    assert page.has_content?("www.awesome-office.com")
    assert page.has_content?("Warschauer Str. 41, 10243 Berlin")
  end

  test "testing feature: create an experience" do
    # click on the dropdown menu to visit your dashboard
    find('img#navbarDropdown').click
    click_on 'Dashboard'

    # add an experience
    click_on 'Add experience'

    # fill out the form and submit a new experience
    select '100Landschaftsarchitektur', from: 'experience_office_id'
    fill_in "experience_job_position", with: "Dipl.-Ing. Architektin"
    find(".datepicker", match: :first).click
    find(".flatpickr-day", match: :first).click

    click_on 'Create experience', match: :prefer_exact

    # check if experience was added
    assert_current_path user_path(@user)

    @experience = Experience.last

    save_and_open_screenshot

    assert page.has_content?(@experience.office.name)
    assert page.has_content?(@experience.job_position)
    assert page.has_content?(@experience.start_date.strftime("%B %Y"))
  end
end

