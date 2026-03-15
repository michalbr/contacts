require "application_system_test_case"

class ContactLabelsTest < ApplicationSystemTestCase
  test "filters contacts by label" do
    label1 = Label.create!(name: "Friends")
    label2 = Label.create!(name: "Family")
    contact1 = Contact.create!(first_name: "Tom", last_name: "Jones")
    contact2 = Contact.create!(first_name: "Jane", last_name: "Doe")
    contact1.labels << label1

    visit contacts_path
    assert_text "Tom Jones"
    assert_text "Jane Doe"

    click_on "Friends"
    assert_text "Tom Jones"
    assert_no_text "Jane Doe"

    click_on "Family"
    assert_no_text "Tom Jones"
    assert_no_text "Jane Doe"
    assert_text "No contacts found."

    click_on "Contacts"
    assert_text "Tom Jones"
    assert_text "Jane Doe"
  end
end
