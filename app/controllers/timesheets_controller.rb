class TimesheetsController < ApplicationController
  # GET /timesheets
  # GET /timesheets.xml
  def index
    if params[:project_id]
      @timesheets = Timesheet.where(:project_id => params[:project_id]).paginate (:page => params[:page], :per_page => 15)
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
    @project = Project.find(@timesheet.project_id)
    @start_date = @timesheet.start_date
    @employees = Employee.find_all_by_project_id(@project.id)
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
  
  def update_timesheet
    @timesheet = Timesheet.find(params[:id])
    @employees = Employee.find_all_by_project_id(@timesheet.project_id)
    @start_date = @timesheet.start_date
    
    @employees.each do |employee|                                
      (0..6).each do |n|
        current_date = @start_date + n
        if params[employee.id.to_s + ":" + current_date.to_s] == 'selected'
          # check if the existing work day exist
          if @timesheet.work_days.find_by_employee_id_and_day(employee.id, current_date) == nil 
            logger.debug "Created work day for #{employee.name}"
            work_day = WorkDay.new(:timesheet_id => @timesheet.id,
                                  :employee_id => employee.id,
                                  :day => current_date)
            work_day.save
          end
        end
      end
    end
    
    summary = @timesheet.summary
    summary.write_cached(@timesheet, Project.find(@timesheet.project_id))
    
    respond_to do |format|
      if @timesheet.update_attributes(params[:timesheet])
        format.html { redirect_to :action => "show_summary", :id => @timesheet.id, :notice => 'Timesheet was successfully updated.' }
        format.xml  { render :xml => @timesheet.summary }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end
end
