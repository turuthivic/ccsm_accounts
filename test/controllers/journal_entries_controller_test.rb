require "test_helper"

class JournalEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @journal_entry = journal_entries(:one)
  end

  test "should get index" do
    get journal_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_journal_entry_url
    assert_response :success
  end

  test "should create journal_entry" do
    assert_difference("JournalEntry.count") do
      post journal_entries_url, params: { journal_entry: { amount: @journal_entry.amount, creation_date: @journal_entry.creation_date, data: @journal_entry.data, error: @journal_entry.error, statement_id: @journal_entry.statement_id, type: @journal_entry.type, value_date: @journal_entry.value_date } }
    end

    assert_redirected_to journal_entry_url(JournalEntry.last)
  end

  test "should show journal_entry" do
    get journal_entry_url(@journal_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_journal_entry_url(@journal_entry)
    assert_response :success
  end

  test "should update journal_entry" do
    patch journal_entry_url(@journal_entry), params: { journal_entry: { amount: @journal_entry.amount, creation_date: @journal_entry.creation_date, data: @journal_entry.data, error: @journal_entry.error, statement_id: @journal_entry.statement_id, type: @journal_entry.type, value_date: @journal_entry.value_date } }
    assert_redirected_to journal_entry_url(@journal_entry)
  end

  test "should destroy journal_entry" do
    assert_difference("JournalEntry.count", -1) do
      delete journal_entry_url(@journal_entry)
    end

    assert_redirected_to journal_entries_url
  end
end
