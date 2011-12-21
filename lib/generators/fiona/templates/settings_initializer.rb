defaults = {
  app_name: 'My Awesome Rails App'
}

begin
  S = SettingsTemplate.find_or_initialize_by_key('settings')
  S.default_attributes = defaults
  S.save!
rescue
end
