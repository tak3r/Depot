class ProjectsController < ApplicationController

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.paginate :page => params[:page], :order => 'name', :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @employees = Employee.find_all_by_project_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end
  
  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /projects/1/add_employee
  def add_employee
    @employees = Employee.paginate :page => params[:page], :order => 'name', :per_page => 10
    @project = Project.find(params[:id])
    
    respond_to do |format|
      format.html #addEmployee.html.erb
      format.xml { render :xml => @project }
    end
  end

  # POST /projects/1/update_employee  
  def update_employee
    @employees = Employee.all
    @project = Project.find(params[:id])
    
    @employees.each do |employee|
      if(params[employee.id.to_s()] == 'selected')
        employee.project_id = @project.id
        employee.save
      elsif(employee.project_id == @project.id)
        # being removed from the project.
        employee.project_id = 0
        employee.save
      end
    end
    
    respond_to do |format|
      format.html { redirect_to(@project, :notice => 'Employee updated')}
      format.xml  { render :xml => @project, :status => :updated, :location => @project }
    end
  end
  
  # POST /projects/1/remove_employee
  def remove_employee
    @employee = Employee.find(params[:employee_id])
    @project = Project.find(params[:id])
    
    @employee.project_id = 0
    
    respond_to do |format|
      if(@employee.save)
        format.html { redirect_to(@project, :notice => "#{@employee.name} removed from #{@project.name}")}
        format.xml { render :xml => @project, :status => :updated, :location => @project }
      else
        format.html { redirect_to(@project, :notice => "Errors occured when removing #{@employee.name}")}
        format.xml  { render :xml => @project.errors, :status => :unsuccessful_remove_employee }
      end
    end
  end
  
  def create_timesheet
    @start_date = Date.civil(params[:range][:"start_date(1i)"].to_i, params[:range][:"start_date(2i)"].to_i, params[:range][:"start_date(3i)"].to_i)
    
    logger.debug "start date is #{@start_date}"
    respond_to do |format|
      format.html { redirect_to :action => 'create_weekly_timesheet', :start_date => @start_date}
      format.xml { render :xml => @porject, :status => :createWeeklyTimesheet, :location => @project}
    end
  end
  
  # GET projects/1/create_weekly_timesheet
  def create_weekly_timesheet
    @project = Project.find(params[:id])
    
    if params[:start_date]
      @start_date = Date.strptime(params[:start_date], "%Y-%m-%d")
      @employees = Employee.find_all_by_project_id(params[:id])
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end
  
  # POST projects/1/created_weekly_timesheet
  def created_weekly_timesheet
    @project = Project.find(params[:id])
    @employees = Employee.find_all_by_project_id(params[:id])
    
    @start_date = Date.strptime(params[:start_date], "%Y-%m-%d")
    
    @timesheet = Timesheet.new( :project_id => @project.id,
                                :start_date => @start_date)
    if !@timesheet.save
      respond_to do |format|
          format.html { redirect_to :action => 'create_weekly_timesheet', :start_date => @start_date, :notice => "Failed to create timesheet"}
          format.xml { render :xml => @porject.errors, :status => :unsuccessful_create_timesheet}
      end
    end
    
    @employees.each do |employee|                                
      (0..6).each do |n|
        current_date = @start_date + n
        if params[employee.id.to_s + ":" + current_date.to_s] == 'selected'
          logger.debug "Created work day for #{employee.name}"
          work_day = WorkDay.new(:timesheet_id => @timesheet.id,
                                  :employee_id => employee.id,
                                  :day => current_date)
          work_day.save
        end
      end
    end
    
    summary = Summary.new( :timesheet_id => @timesheet.id)
    summary.write_cached(@timesheet, @project)
    
    logger.debug 'Create time sheet'
    
    respond_to do |format|
        format.html { redirect_to :controller => "timesheets", :action => "show_summary", :id => @timesheet.id }
        format.xml  { render :xml => @timesheet.summary }
    end
  end
end
