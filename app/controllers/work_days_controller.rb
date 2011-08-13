class WorkDaysController < ApplicationController
  # GET /work_days
  # GET /work_days.xml
  def index
    @work_days = WorkDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @work_days }
    end
  end

  # GET /work_days/1
  # GET /work_days/1.xml
  def show
    @work_day = WorkDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work_day }
    end
  end

  # GET /work_days/new
  # GET /work_days/new.xml
  def new
    @work_day = WorkDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work_day }
    end
  end

  # GET /work_days/1/edit
  def edit
    @work_day = WorkDay.find(params[:id])
  end

  # POST /work_days
  # POST /work_days.xml
  def create
    @work_day = WorkDay.new(params[:work_day])

    respond_to do |format|
      if @work_day.save
        format.html { redirect_to(@work_day, :notice => 'Work day was successfully created.') }
        format.xml  { render :xml => @work_day, :status => :created, :location => @work_day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /work_days/1
  # PUT /work_days/1.xml
  def update
    @work_day = WorkDay.find(params[:id])

    respond_to do |format|
      if @work_day.update_attributes(params[:work_day])
        format.html { redirect_to(@work_day, :notice => 'Work day was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /work_days/1
  # DELETE /work_days/1.xml
  def destroy
    @work_day = WorkDay.find(params[:id])
    @work_day.destroy

    respond_to do |format|
      format.html { redirect_to(work_days_url) }
      format.xml  { head :ok }
    end
  end
end
