require "application_system_test_case"

class StatementsTest < ApplicationSystemTestCase
  setup do
    @statement = statements(:one)
  end

  test "visiting the index" do
    visit statements_url
    assert_selector "h1", text: "Statements"
  end

  test "should create statement" do
    visit statements_url
    click_on "New statement"

    fill_in "Data", with: @statement.data
    fill_in "End date", with: @statement.end_date
    fill_in "Error", with: @statement.error
    fill_in "Extracted data", with: @statement.extracted_data
    fill_in "Name", with: @statement.name
    fill_in "Start date", with: @statement.start_date
    fill_in "Uploaded at", with: @statement.uploaded_at
    fill_in "Uploaded by", with: @statement.uploaded_by
    fill_in "User", with: @statement.user_id
    click_on "Create Statement"

    assert_text "Statement was successfully created"
    click_on "Back"
  end

  test "should update Statement" do
    visit statement_url(@statement)
    click_on "Edit this statement", match: :first

    fill_in "Data", with: @statement.data
    fill_in "End date", with: @statement.end_date.to_s
    fill_in "Error", with: @statement.error
    fill_in "Extracted data", with: @statement.extracted_data
    fill_in "Name", with: @statement.name
    fill_in "Start date", with: @statement.start_date.to_s
    fill_in "Uploaded at", with: @statement.uploaded_at.to_s
    fill_in "Uploaded by", with: @statement.uploaded_by
    fill_in "User", with: @statement.user_id
    click_on "Update Statement"

    assert_text "Statement was successfully updated"
    click_on "Back"
  end

  test "should destroy Statement" do
    visit statement_url(@statement)
    click_on "Destroy this statement", match: :first

    assert_text "Statement was successfully destroyed"
  end
end
