require "test_helper"

class LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_label_url
    assert_response :success
    assert_template :new
    assert assigns(:label).new_record?
  end

  test "should create label" do
    assert_difference "Label.count", 1 do
      post labels_path, params: { label: { name: "Friends" } }, as: :turbo_stream
    end
    assert_equal Label.order(:name), Rails.cache.read("labels")
    assert_response :success
    assert_equal "Label was successfully created", flash[:notice]

    assert_turbo_stream action: "update", target: "modal"
    assert_turbo_stream action: "update", target: "labels-list"
    assert_turbo_stream action: "append", target: "toasts"
  end

  test "should not create label with invalid data" do
    assert_no_difference "Label.count" do
      post labels_path, params: { label: { name: "" } }, as: :turbo_stream
    end
    assert_turbo_stream action: "replace", target: "modal", status: :unprocessable_entity
    assert assigns(:label).errors.any?
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    label = Label.create!(name: "Friends")
    get edit_label_path(label)
    assert_response :ok
    assert_template :edit
    assert_equal label, assigns(:label)
  end

  test "should return 404 when label for edit not found" do
    get edit_label_path(id: 0)
    assert_response :not_found
  end

  test "should update label" do
    label = Label.create!(name: "Friends")
    patch label_path(label), params: { label: { name: "Family" } }, as: :turbo_stream
    label.reload
    assert_equal "Family", label.name
    assert_equal Label.order(:name), Rails.cache.read("labels")
    assert_response :success
    assert_equal "Label was successfully updated", flash[:notice]
    assert_turbo_stream action: "update", target: "modal"
    assert_turbo_stream action: "update", target: "labels-list"
    assert_turbo_stream action: "append", target: "toasts"
  end

  test "should return 404 when label for update not found" do
    patch label_path(id: 0), params: { label: { name: "Friends" } }, as: :turbo_stream
    assert_response :not_found
  end

  test "should not update label with invalid data" do
    label = Label.create!(name: "Friends")
    patch label_path(label), params: { label: { name: "" } }, as: :turbo_stream
    label.reload
    assert_equal "Friends", label.name

    assert_turbo_stream action: "replace", target: "modal", status: :unprocessable_entity
    assert assigns(:label).errors.any?
    assert_response :unprocessable_entity
  end

  test "should destroy label" do
    label = Label.create!(name: "Friends")
    assert_difference "Label.count", -1 do
      delete label_path(label), as: :turbo_stream
    end
    assert_equal Label.order(:name), Rails.cache.read("labels")
    assert_equal "Label was successfully deleted", flash[:notice]

    assert_turbo_stream action: "replace", target: "confirm_modal_backdrop"
    assert_turbo_stream action: "update", target: "labels-list"
    assert_turbo_stream action: "append", target: "toasts"
  end

  test "should return 404 when label for delete not found" do
    delete label_path(id: 0)
    assert_response :not_found
  end
end
