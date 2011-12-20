class FionaGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end

  def create_migration
    migration_template 'create_fiona_tables.rb', 'db/migrate/create_fiona_tables.rb'
  end

  def create_initializer
    copy_file 'settings_initializer.rb', 'config/initializers/settings.rb'
  end

  def create_templates
    copy_file 'settings_template.rb', 'app/templates/settings_template.rb'
  end
end
