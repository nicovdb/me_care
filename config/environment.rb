# Load the Rails application.
require_relative 'application'

# load additionnal environment variables here from file (so that they are loaded before environments/*.rb)
app_environment_variables = File.join(Rails.root, 'config', '.env.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!
