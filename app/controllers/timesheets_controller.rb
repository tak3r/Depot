class TimesheetsController < ApplicationController
  # GET /timesheets
  # GET /timesheets.xml
  def index
    if params[:project_id]
      @timesheets = Timesheet.find_all_by_project_id(params[:project_id])
      @project = Project.find(params[:project_id])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timesheets }
    end
  end

  # GET /timesheets/1
  # GET /timesheets/1.xml
  def show
    @timesheet = Timesheet.find(params[:id])
    @project = Project.find(@timesheet.project_id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timesheet }
    end
  end

  # GET /timesheets/new
  # GET /timesheets/new.xml
  def new
    @timesheet = Timesheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timesheet }
    end
  end

  # GET /timesheets/1/edit
  def edit
    @timesheet = Timesheet.find(params[:id])
  end

  # POST /timesheets
  # POST /timesheets.xml
  def create
    respond_to do |format|
      if params[:project]
        format.html { redirect_to(:action => "index", :project_id => params[:project][:id])}
        format.xml { render :xml => @timesheets }
      else
        format.html { redirect_to(:action => "index")}
        format.xml { render :xml => @timesheets }
      end
    end
  end

  # PUT /timesheets/1
  # PUT /timesheets/1.xml
  def update
    @timesheet = Timesheet.find(params[:id])

    respond_to do |format|
      if @timesheet.update_attributes(params[:timesheet])
        format.html { redirect_to(@timesheet, :notice => 'Timesheet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timesheets/1
  # DELETE /timesheets/1.xml
  def destroy
    @timesheet = Timesheet.find(params[:id])
    @project = Project.find(@timesheet.project_id)
    @timesheet.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "index", :project_id => @project.id) }
      format.xml  { head :ok }
    end
  end
  
  def show_summary
    @summary = Summary.find_by_timesheet_id(params[:id])
    @project = Project.find(Timesheet.find(params[:id]).project_id)
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @summary}
    end
  end
end
