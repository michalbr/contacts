require "application_system_test_case"

class LabelsTest < ApplicationSystemTestCase
  test "creates a label" do
    visit contacts_path
    find("a[href='#{new_label_path}']").click

    fill_in "Name", with: "Friends"
    click_on "Create Label"

    assert_text "Friends"
  end

  test "edits a label" do
    label = Label.create!(name: "Friends")

    visit contacts_path
    link = find("a[href='#{edit_label_path(label)}']", visible: false)
    execute_script("arguments[0].click()", link)

    fill_in "Name", with: "Family"
    click_on "Update Label"

    assert_text "Family"
    assert_no_text "Friends"
  end

  test "deletes a label" do
    label = Label.create!(name: "Friends")

    visit contacts_path
    button = find("[data-testid='delete-label-button']", visible: false)
    execute_script("arguments[0].click()", button)
    click_on "Delete"

    assert_no_text "Friends"
  end
end
