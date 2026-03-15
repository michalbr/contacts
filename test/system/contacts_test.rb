require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  test "shows empty state when no contacts" do
    visit contacts_path
    assert_text "No contacts found."
  end

  test "creates a contact" do
    label = Label.create!(name: "Friends")

    visit contacts_path
    click_on "New Contact"

    fill_in "First name", with: "Tom"
    fill_in "Last name", with: "Jones"
    fill_in "Email", with: "tom@jones.com"
    fill_in "Note", with: "some note"
    check "Friends"
    click_on "Create Contact"

    assert_current_path contacts_path
    assert_text "Tom Jones"
  end

  test "edits a contact" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    visit contact_path(contact)
    find("a[href='#{edit_contact_path(contact)}']").click

    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    click_on "Update Contact"

    assert_current_path contact_path(contact)
    assert_text "John Smith"
  end

  test "deletes a contact" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    visit contact_path(contact)
    find("[data-testid='delete-contact-button']").click
    click_on "Delete"

    assert_current_path contacts_path
    assert_no_text "Tom Jones"
  end
end
