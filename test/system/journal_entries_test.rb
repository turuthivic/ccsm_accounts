require "application_system_test_case"

class JournalEntriesTest < ApplicationSystemTestCase
  setup do
    @journal_entry = journal_entries(:one)
  end

  test "visiting the index" do
    visit journal_entries_url
    assert_selector "h1", text: "Journal entries"
  end

  test "should create journal entry" do
    visit journal_entries_url
    click_on "New journal entry"

    fill_in "Amount", with: @journal_entry.amount
    fill_in "Creation date", with: @journal_entry.creation_date
    fill_in "Data", with: @journal_entry.data
    fill_in "Error", with: @journal_entry.error
    fill_in "Statement", with: @journal_entry.statement_id
    fill_in "Type", with: @journal_entry.type
    fill_in "Value date", with: @journal_entry.value_date
    click_on "Create Journal entry"

    assert_text "Journal entry was successfully created"
    click_on "Back"
  end

  test "should update Journal entry" do
    visit journal_entry_url(@journal_entry)
    click_on "Edit this journal entry", match: :first

    fill_in "Amount", with: @journal_entry.amount
    fill_in "Creation date", with: @journal_entry.creation_date.to_s
    fill_in "Data", with: @journal_entry.data
    fill_in "Error", with: @journal_entry.error
    fill_in "Statement", with: @journal_entry.statement_id
    fill_in "Type", with: @journal_entry.type
    fill_in "Value date", with: @journal_entry.value_date.to_s
    click_on "Update Journal entry"

    assert_text "Journal entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Journal entry" do
    visit journal_entry_url(@journal_entry)
    click_on "Destroy this journal entry", match: :first

    assert_text "Journal entry was successfully destroyed"
  end
end
