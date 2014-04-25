module ApiModelRecurrenceModule
  
  def get_dates_from_setting(user_context, id)
    OpenObject.rescue_xmlrpc_fault do
      response = self.class.connection(user_context).execute(self.class.open_object_model, 'get_dates', id)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end
end