# Specify your default setting values here.
defaults = {
  app_name: 'My Awesome Rails App'
}


# Don't mess with this unless you know what you are doing.
S = SettingsTemplate.find_or_initialize_by_key('settings')
S.default_attributes = defaults
S.save!
