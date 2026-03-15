require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contacts_url
    assert_response :success
    assert_template :index
  end

  test "should fetch all contacts" do
    Contact.create!(first_name: "Tom", last_name: "Jones")
    get contacts_path
    assert_equal Contact.count, assigns(:contacts).count
  end

  test "should filter contacts by label" do
    contact1 = Contact.create!(first_name: "Tom", last_name: "Jones")
    contact2 = Contact.create!(first_name: "Jane", last_name: "Doe")
    label = Label.create!(name: "Friends")
    contact1.labels << label

    get contacts_path(label_id: label.id)

    assert_response :success
    assert_template :index
    assert_includes assigns(:contacts), contact1
    assert_not_includes assigns(:contacts), contact2
    assert_equal assigns(:label), label
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
    assert_template :new
    assert assigns(:contact).new_record?
  end

  test "should create contact" do
    assert_difference "Contact.count", 1 do
      post contacts_path, params: {
        contact: {
          first_name: "Tom",
          last_name: "Jones",
          email: "tom@jones.com",
          note: "some note"
        }
      }
    end
    assert_equal "tom@jones.com", Contact.last.email
    assert_equal "some note", Contact.last.note
    assert_redirected_to contacts_path
    assert_equal "Contact was successfully created", flash[:notice]
  end

  test "should not create contact with invalid data" do
    assert_no_difference "Contact.count" do
      post contacts_path, params: { contact: { first_name: "", last_name: "" } }
    end
    assert_template :new
    assert assigns(:contact).errors.any?
    assert_response :unprocessable_entity
  end

  test "should show contact" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")
    get contact_path(contact)
    assert_response :ok
    assert_template :show
    assert_equal contact, assigns(:contact)
  end

  test "should return 404 when contact not found" do
    get contact_path(id: 0)
    assert_response :not_found
  end

  test "should get edit" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")
    get edit_contact_path(contact)
    assert_response :ok
    assert_template :edit
    assert_equal contact, assigns(:contact)
  end

  test "should return 404 when contact for edit not found" do
    get edit_contact_path(id: 0)
    assert_response :not_found
  end

  test "should update contact" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")
    patch contact_path(contact), params: {
      contact: {
        first_name: "Marky",
        last_name: "Mark",
        email: "marky@mark.com",
        note: "some note"
      }
    }
    assert_redirected_to contact_path(contact)
    contact.reload
    assert_equal "Marky", contact.first_name
    assert_equal "Mark", contact.last_name
    assert_equal "marky@mark.com", contact.email
    assert_equal "some note", contact.note
    assert_equal "Contact was successfully updated", flash[:notice]
  end

  test "should return 404 when contact for update not found" do
    patch contact_path(id: 0), params: {
      contact: {
        first_name: "Marky",
        last_name: "Mark",
        email: "marky@mark.com",
        note: "some note"
      }
    }
    assert_response :not_found
  end

  test "should not update contact with invalid data" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")
    patch contact_path(contact), params: {
      contact: { first_name: "", last_name: "" }
    }
    contact.reload
    assert_equal "Tom", contact.first_name
    assert_equal "Jones", contact.last_name
    assert_template :edit
    assert assigns(:contact).errors.any?
    assert_response :unprocessable_entity
  end

  test "should destroy contact" do
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")
    assert_difference "Contact.count", -1 do
      delete contact_path(contact)
    end
    assert_redirected_to contacts_path
    assert_equal "Contact was successfully deleted", flash[:notice]
  end

  test "should return 404 when contact for delete not found" do
    delete contact_path(id: 0)
    assert_response :not_found
  end

  # labels accessible
  test "should set labels" do
    get contacts_path
    assert_not_nil assigns(:labels)
  end

  # views
  test "show displays contact name and handles blank fields" do
    contact = Contact.create!(
      first_name: "Tom",
      last_name: "Jones",
      email: nil,
      note: "some note"
    )

    get contact_path(contact)

    assert_response :success
    assert_select "a[href=?]", contacts_path, text: /Back to contacts/
    assert_select "h1", "Tom Jones"
    assert_includes response.body, "—"
    assert_includes response.body, "some note"
  end
end
