class Openstc::TaskSchedule
  include OpenObjectModel

  @@available_fields = %w(task_id start_working_time end_working_time start_lunch_lime end_lunch_time start_dt team_mode calendar_id)
  attr_accessor *@@available_fields

  def self.create(user_context, args = {})
    OpenObject.rescue_xmlrpc_fault do
      response = self.connection(user_context).execute('project.task', 'planTasks', [args['task_id']], args.except('task_id'))
      BackendResponse.new({success: true, content: response})
    end
  end

end