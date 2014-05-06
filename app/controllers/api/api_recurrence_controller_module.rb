module Api::ApiRecurrenceControllerModule
  
  #api :GET, '/openpatrimoine/recurrence_dates', 'Compute and returns dates according to recurrence setting, mandatory: type (daily, weekly, daymonthly, weekdaymonthly)'
  def recurrence_dates
    @myInstance = self.class.resource_model.new
    backend_response_to_json  @myInstance.get_dates_from_setting(user_context, params[:id].to_i)
  end
  
end