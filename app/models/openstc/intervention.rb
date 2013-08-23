class Openstc::Intervention
  include OpenObjectModel
  set_open_object_model 'project.project'
  @@available_fields = %w(id name description tasks state service_id site1 date_deadline planned_hours effective_hours tooltip progress_rate overPourcent actions ask_id create_uid)

  @@available_fields.each do |field|
    attr_accessor field
  end

end