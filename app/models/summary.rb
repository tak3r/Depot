class Summary < ActiveRecord::Base
  belongs_to :timesheet
  
  def write_cached(timesheet, project)
    self.cached_content = ActionView::Base.new(Rails::Application.instance.config.view_path).render(:partial => "projects/summary", :locals => {:timesheet => timesheet, :project => project})
    logger.debug "#{@cached_content}"
    self.save
  end
end
