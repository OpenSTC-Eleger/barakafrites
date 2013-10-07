Apipie.configure do |config|
  config.app_name                = "Barakafrites"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api_documentation"
  # were is your API defined?
  config.api_controllers_matcher = ["#{Rails.root}/app/controllers/api/**/*.rb", "#{Rails.root}/app/controllers/api/*.rb", "#{Rails.root}/app/controllers/sessions_controller.rb"]
end
