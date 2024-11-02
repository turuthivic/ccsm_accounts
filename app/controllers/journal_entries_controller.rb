class JournalEntriesController < ApplicationController
  before_action :set_journal_entry, only: %i[show edit update destroy]

  # GET /journal_entries or /journal_entries.json
  def index
    @journal_entries = JournalEntry.all
  end

  # GET /journal_entries/1 or /journal_entries/1.json
  def show
  end

  # GET /journal_entries/new
  def new
    @journal_entry = JournalEntry.new
    @statements = Statement.all
                           .where('created_at > ?', 1.month.ago)
  end

  # GET /journal_entries/1/edit
  def edit
    @statements = Statement.all
                           .where('created_at > ?', 1.month.ago)
  end

  # POST /journal_entries or /journal_entries.json
  def create
    my_params = journal_entry_params
    my_params['statement_id'] = params['statement_id']
    my_params['entry_type'] = params['entry_type'].to_i
    puts "unfiltered params: #{my_params}"
    @journal_entry = JournalEntry.new(my_params)

    respond_to do |format|
      if @journal_entry.save
        format.html { redirect_to @journal_entry, notice: 'Journal entry was successfully created.' }
        format.json { render :show, status: :created, location: @journal_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journal_entries/1 or /journal_entries/1.json
  def update
    respond_to do |format|
      if @journal_entry.update(journal_entry_params)
        format.html { redirect_to @journal_entry, notice: 'Journal entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @journal_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @journal_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /journal_entries/1 or /journal_entries/1.json
  def destroy
    @journal_entry.destroy!

    respond_to do |format|
      format.html do
        redirect_to journal_entries_path, status: :see_other, notice: 'Journal entry was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_journal_entry
    @journal_entry = JournalEntry.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def journal_entry_params
    params.expect(journal_entry: %i[entry_type amount value_date creation_date statement_id])
  end
end
