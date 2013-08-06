class Openstc::Intervention
  include OpenObjectModel
  set_open_object_model 'project.project'
  @@available_fields = %w(id name description state service_id site1 date_start date_end)
end