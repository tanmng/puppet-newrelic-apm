# newrelic_apm

## Overview

A puppet module to support setting up newrelic APM resources

## Module Description
TODO

## Setup

[Install](https://puppet.com/docs/puppet/5.5/modules_installing.html) the newrelic_apm module to add the resources of this library to Puppet.

If you are authoring a module that depends on stdlib, be sure to [specify dependencies](https://puppet.com/docs/puppet/5.5/modules_metadata.html#specifying-dependencies-in-modules) in your metadata.json.

## Reference

### Defined types

#### `newrelic_apm::java`

Download and _potentially_ set up newrelic APM for Java

Example:

```puppet
  newrelic_apm::java {'solr_nr_apm':
    path           => '/opt/solr',
    config_data    => {
      license_key => '12345463235',
      app_name    => 'Production SOLR',
    }
  }
```

**Parameters**

##### `path`
**required**

The path in which we should install NewRelic APM for Java. This has to be an absolute path. The resource will create a directory called `newrelic` inside of this path, download and extract the NewRelic APM zip file for Java into it.

Values: String which has to be an absolute path.

##### `version`
**optional**

Specify the version of NewRelic APM for Java that we wish to install. We download these version from [NewRelic's own repo](http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/), you can check that out for the full list of versions

Values: String.

Default value: `current`

##### `config_data`
**optional**

Configuration data for the NewRelic APM for Java that we will set up. See the document on `config_data` of `newrelic_apm::config` below for further details. A full list of configuration data for NewRelic Java APM is available [here](https://docs.newrelic.com/docs/agents/java-agent/configuration/java-agent-configuration-config-file)

Values: Hash.

Default value: `{}`

##### `download_only`
**optional**

Specify whether we should only download and extract the APM, but NOT configure it (you can always configure it later with `newrelic_apm::config` resource as shown below. In fact, `newrelic_apm::java` (and all other types) just use `newrelic_apm::config` to set up the configuration anyway.

Values: Boolean

Default value: `false`

#### `newrelic_apm::config`

Set up configuration in newrelic config file with the data that you provide

Example:

```puppet
  newrelic_apm::config {'solr_nr_apm_config':
    config_file    => '/opt/solr/newrelic/newrelic.yml',
    config_data    => {
      license_key => '12345463235',
      app_name    => 'Production SOLR',
    }
  }
```

**Parameters**

##### `config_file`
**required**

Path to the `yml` configuration file.

Values: String.

##### `config_data`
**optional** _but what is the point of calling this resource and not specifying this, amirite?_

A hash containing configuration data. It should be in the form of `config_key` => `config_value`. For a complete list of available `config_key`, checkout [Newrelic's configure the Agent document](https://docs.newrelic.com/docs/agents/manage-apm-agents/configuration/configure-agent)

Values: Hash

## Contribution

Any contribution on the module is greatly welcomed. Please feel free to fork,
improve the module and give me a PR.

## Todo

Following list is the ideas of what we want to improve/change:
* Autotest files
* Try out other resource type
