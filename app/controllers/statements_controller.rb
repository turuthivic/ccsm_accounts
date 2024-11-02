class StatementsController < ApplicationController
  before_action :set_statement, only: %i[show edit update destroy]

  # GET /statements or /statements.json
  def index
    @statements = Statement.all
  end

  # GET /statements/1 or /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = Statement.new
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements or /statements.json
  def create
    params = statement_params
    params[:uploaded_at] = DateTime.now
    params[:user] = current_user
    params[:name] = ''
    @statement = Statement.new(params)

    respond_to do |format|
      if @statement.save
        process_statement
        format.html do
          redirect_to @statement, notice: 'Statement was successfully created.'
        end
        format.json { render :show, status: :created, location: @statement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @statement.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /statements/1 or /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html do
          redirect_to @statement, notice: 'Statement was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @statement.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /statements/1 or /statements/1.json
  def destroy
    @statement.destroy!

    respond_to do |format|
      format.html do
        redirect_to statements_path, status: :see_other,
                                     notice: 'Statement was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_statement
    @statement = Statement.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def statement_params
    params.expect(statement: %i[name start_date end_date statement])
  end

  def process_statement
    unless @statement.statement.attached?
      return Rails.logger.error('Statement is not attached for '\
                                "#{@statement.id}")
    end

    password = nil # RailsEnv.xapic_equity_statement_password
    attached_object = { klass: 'Statement',
                        id: @statement.id,
                        attached: 'statement' }
    processed_file = ParsePdfService.call(password: password,
                                          active_record: true,
                                          attached_object: attached_object)
    @statement.update(data: { unprocessed_data: processed_file },
                      name: file_name)
    puts "processed_file: #{processed_file}" if @statement.save
  end

  ##
  # @return [String]
  def file_name
    file_location = Rails.application
                         .routes
                         .url_helpers
                         .rails_blob_path(@statement.statement,
                                          only_path: true).to_s
    file_location.split('/').last
  end
end
