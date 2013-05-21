module Config
  @vars = YAML.load_file(Rails.root + 'config/config.yml')

  def self.get
    @vars[Rails.env].with_indifferent_access
  end

end