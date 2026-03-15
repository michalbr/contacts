require "test_helper"

class ContactTest < ActiveSupport::TestCase
  # can't add same label to the contact twice
  test "first_name must be present" do
    assert_not Contact.new(last_name: "Doe").valid?
  end

  test "last_name must be present" do
    assert_not Contact.new(first_name: "John").valid?
  end

  test "valid with first_name and last_name" do
    assert Contact.new(first_name: "John", last_name: "Doe").valid?
  end

  test "valid with proper email" do
    assert Contact.new(
      email: "test@example.com",
      first_name: "John",
      last_name: "Doe"
    ).valid?
  end

  test "invalid with bad email" do
    assert_not Contact.new(
      email: "notanemail",
      first_name: "John",
      last_name: "Doe"
    ).valid?
  end

  test "can have many labels" do
    label1 = Label.create!(name: "Friends")
    label2 = Label.create!(name: "Gym")
    contact = Contact.create!(first_name: "John", last_name: "Doe")

    contact.labels << label1
    contact.labels << label2

    assert_equal 2, contact.labels.count
  end

  test "destroying contact does not destroy its labels" do
    label = Label.create!(name: "Friends")
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    contact.labels << label
    contact.destroy

    assert Label.exists?(label.id)
  end

  test "can't add same label twice" do
    label = Label.create!(name: "Friends")
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    contact.labels << label

    assert_raises ActiveRecord::RecordNotUnique do
      contact.labels << label
    end
  end
end
