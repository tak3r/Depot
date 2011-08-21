class EmployeesController < ApplicationController
  # GET /employees
  # GET /employees.xml
  def index
    @employees = Employee.paginate :page => params[:page], :order => 'name', :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.xml
  def show
    @employee = Employee.find(params[:id])
    @project = nil
    
    if @employee.project_id > 0
      @project = Project.find(@employee.project_id)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.xml
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end
  
  # POST /employees
  # POST /employees.xml
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to(@employee, :notice => 'Employee was successfully created.') }
        format.xml  { render :xml => @employee, :status => :created, :location => @employee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to(@employee, :notice => 'Employee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to(employees_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /employees/1/addToProject
  def addToProject
    @employee = Employee.find(params[:id])
    @projects = Project.all
    
    respond_to do |format|
      format.html #addToProject.html.erb
      format.xml { render :xml => @employee }
    end
  end
  
  # POST /employees/1/updateEmployee  
  def updateEmployee
    @employee = Employee.find(params[:id])
    
    logger.debug "project id is #{params['employee']['project_id']}"
    @employee.project_id = params['employee']['project_id']
    @employee.save
    
    respond_to do |format|
      format.html { redirect_to (@employee, :notice => 'Employee updated')}
      format.xml  { render :xml => @employee, :status => :updated, :location => @employee }
    end
  end
end
