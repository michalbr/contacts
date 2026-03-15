require "test_helper"

class ContactFlowsTest < ActionDispatch::IntegrationTest
  test "creates contact that appears in index" do
    get new_contact_path
    assert_response :success

    post contacts_path, params: { contact: { first_name: "Tom", last_name: "Jones", email: "tom@jones.com", note: "some note" } }
    assert_redirected_to contacts_path
    follow_redirect!

    assert_response :success
    assert_select "a", "Tom Jones"
  end

  test "edits contact" do
    contact = Contact.create!(
      first_name: "Tom",
      last_name: "Jones",
      email: "tom@jones.com",
      note: "some note"
    )

    get edit_contact_path(contact)
    assert_response :success

    patch contact_path(contact), params: { contact: { first_name: "New", last_name: "Name" } }
    assert_redirected_to contact_path(contact)
    follow_redirect!

    assert_response :success
    assert_select "h1", "New Name"
  end

  test "deletes contact" do
    contact = Contact.create!(
      first_name: "Tom",
      last_name: "Jones"
    )

    delete contact_path(contact)
    assert_redirected_to contacts_path
    follow_redirect!

    assert_response :success
    assert_select "a", { text: "Tom Jones", count: 0 }
  end
end
