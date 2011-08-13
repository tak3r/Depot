class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

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
  
  # GET /projects/1/addEmployee
  def addEmployee
    @employees = Employee.all
    @project = Project.find(params[:id])
    
    respond_to do |format|
      format.html #addEmployee.html.erb
      format.xml { render :xml => @project }
    end
  end

  # POST /projects/1/updateEmployee  
  def updateEmployee
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
  
  # POST /projects/1/removeEmployee
  def removeEmployee
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
  
  # GET /projects/1/createTimesheets
  def createTimesheets
    logger.debug 'Create timesheet'
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end
  
  def createdTimesheets
    @project = Project.find(params[:id])
    @start_date = Date.civil(params[:range][:"start_date(1i)"].to_i, params[:range][:"start_date(2i)"].to_i, params[:range][:"start_date(3i)"].to_i)
    
    logger.debug "start date is #{@start_date.to_s}"
    respond_to do |format|
      format.html { redirect_to :action => 'createWeeklyTimesheet', :start_date => @start_date}
      format.xml { render :xml => @porject, :status => :createWeeklyTimesheet, :location => @project}
    end
  end
  
  def createWeeklyTimesheet
    @project = Project.find(params[:id])
    @start_date = Date.strptime(params[:start_date], "%Y-%m-%d")
    @employees = Employee.find_all_by_project_id(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end
end