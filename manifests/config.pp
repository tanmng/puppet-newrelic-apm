# Defined Type newrelic_apm::config
#
# Description
# Modify the configuration for NewRelic APM according to the data we provide
#
# Parameters
# [*config_file*]
# Path of the config file
#
# [*config_data*]
# A hash containing the config data that we wish to set, in the form of
# { config_key => value}
# For a complete list of config_key, see https://docs.newrelic.com/docs/agents/manage-apm-agents/configuration/configure-agent

# ### Author
# tan.mng90@gmail.com
#

define newrelic_apm::config (
  $config_file = '',
  $config_data = {},
) {
  # Validation of variables
  validate_hash($config_data)

  # Change our newrelic config file
  $config_data.each |$field_name, $field_value| {
    file_line {"${title}_${field_name}":
      path     => $config_file,
      line     => "  ${field_name}: ${field_value}",
      match    => "  ${field_name}: .*",
      multiple => ($field_name == "app_name"), # app_name is the special case in which we have to replace all
    }
  }
}
