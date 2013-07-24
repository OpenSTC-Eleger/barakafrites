class Openstc::InterventionRequest
  include OpenObjectModel
  set_open_object_model 'openstc.ask'
  
  @@available_fields = %w(actions belongsToAssignement tooltip belongsToService id name belongsToSite create_date create_uid date_deadline description id intervention_assignement_id intervention_ids manager_id name note partner_address partner_email partner_id partner_phone partner_service_id partner_type partner_type_code people_email people_name people_phone refusal_reason service_id site1 site_details state write_uid)


  attr_accessor *@@available_fields
  

end
