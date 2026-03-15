require "test_helper"

class LabelTest < ActiveSupport::TestCase
  test "name must be present" do
    assert_not Label.new.valid?
  end

  test "valid with name" do
    assert Label.new(name: "Friends").valid?
  end

  test "can have many contacts" do
    contact1 = Contact.create!(first_name: "Tom", last_name: "Jones")
    contact2 = Contact.create!(first_name: "John", last_name: "Doe")
    label = Label.create!(name: "Friends")

    label.contacts << contact1
    label.contacts << contact2

    assert_equal 2, label.contacts.count
  end

  test "destroying label does not destroy its contacts" do
    label = Label.create!(name: "Friends")
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    label.contacts << contact
    label.destroy

    assert Contact.exists?(contact.id)
  end

  test "name must be unique case insensitive - db" do
    Label.create!(name: "Friends")

    assert_raises ActiveRecord::RecordNotUnique do
      label = Label.new(name: "friends")
      label.save(validate: false)
    end
  end

  test "name must be unique case insensitive" do
    Label.create!(name: "Friends")
    label = Label.new(name: "friends")

    assert_not label.valid?
  end

  test "can't add same contact twice" do
    label = Label.create!(name: "Friends")
    contact = Contact.create!(first_name: "Tom", last_name: "Jones")

    label.contacts << contact

    assert_raises ActiveRecord::RecordNotUnique do
      label.contacts << contact
    end
  end
end
