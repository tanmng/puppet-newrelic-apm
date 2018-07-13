# Defined Type newrelic_apm::java
#
# Description
# Set up the Java APM in specified location, configure it with the config data
# that we want
#
# Parameters
# [*version*]
# The version of Java APM that we wish to install.
# A list of all available Java APM is available in http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/
# For latest release, use `current`

# ### Author
# tan.mng90@gmail.com
#

define newrelic_apm::java (
  $ensure        = 'present',
  $version       = 'current',
  $path,
  $config_data   = {},
  $download_only = false,
) {
  # Validation of variables
  validate_hash($config_data)

  # This might be a bit too extreme?
  # if !has_key($config_data, "license_key") {
  # fail("license_key missing in config_data for newrelic_apm::java ${name}")
  # }

  if !is_absolute_path($path) {
    fail('path has to be an abolute path')
  }

  # Download the archive,
  # URL of the ZIP archive is of the form
  # http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/4.2.0/newrelic-java.zip
  # There is another URL
  # http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/4.2.0/newrelic-java-4.2.0.zip
  # But this repeat the version number so I opted not to use it, also, if we use such a URL we cannot set version to `current`
  archive { "newrelic_apm_${title}":
    ensure         => $present,
    allow_insecure => true,
    source         => "http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/${version}/newrelic-java.zip",
    extract        => true,
    extract_path   => "${path}",
    path           => "${path}/newrelic-java-${title}-${version}.zip",
    cleanup        => true,
  }

  if !$download_only {
    $config_file = "${path}/newrelic/newrelic.yml"
    newrelic_apm::config { "config_${title}":
      config_file => $config_file,
      config_data => $config_data,
    }
  }
}
