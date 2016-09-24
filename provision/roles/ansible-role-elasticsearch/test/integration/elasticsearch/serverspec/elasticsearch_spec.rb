require 'serverspec'

# Required by serverspec
set :backend, :exec

case os[:family]
when 'debian','ubuntu'
  package_name = 'elasticsearch'
  service_name = 'elasticsearch'
  config_dir = '/etc/elasticsearch'
  config_file = '/etc/elasticsearch/elasticsearch.yml'
  logging_file = '/etc/elasticsearch/elasticsearch.yml'
  defaults_file = '/etc/default/elasticsearch'
  config_owner = 'root'
  config_group = 'elasticsearch'
when 'redhat','centos'
  package_name = 'elasticsearch'
  service_name = 'elasticsearch'
  config_dir = '/etc/elasticsearch'
  config_file = '/etc/elasticsearch/elasticsearch.yml'
  logging_file = '/etc/elasticsearch/elasticsearch.yml'
  defaults_file = '/etc/sysconfig/elasticsearch'
  config_owner = 'root'
  config_group = 'elasticsearch'
else
  package_name = 'elasticsearch'
  service_name = 'elasticsearch'
  config_dir = '/etc/elasticsearch'
  config_file = '/etc/elasticsearch/elasticsearch.yml'
  logging_file = '/etc/elasticsearch/elasticsearch.yml'
  defaults_file = '/etc/default/elasticsearch'
  config_owner = 'root'
  config_group = 'elasticsearch'
end

describe package(package_name) do
  it { should be_installed }
end

describe file(config_dir) do
  it { should exist }
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by config_owner }
  it { should be_grouped_into config_group }
end

describe file(defaults_file) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /^ES_HEAP_SIZE=[0-9]+m$/ }
  its(:content) { should match /^DATA_DIR=\/data\/elasticsearch$/ }
end

describe file(config_file) do
  it { should exist }
  it { should be_file }
  it { should be_mode 640 }
  it { should be_owned_by config_owner }
  it { should be_grouped_into config_group }
  its(:content) { should match /^network\.host: \[0\.0\.0\.0\]$/ }
  its(:content) { should match /^http\.host: \[0\.0\.0\.0\]$/ }
  its(:content) { should match /^transport\.host: \[0\.0\.0\.0\]$/ }
  its(:content) { should match /^http\.port: 9200$/ }
  its(:content) { should match /^transport\.tcp\.port: 9300$/ }
  its(:content) { should match /^cluster\.name: ServerSpecTesting$/ }
  its(:content) { should match /^node\.name: ServerSpecNode$/ }
  its(:content) { should match /^path\.data: \/data\/elasticsearch$/ }
  its(:content) { should match /^discovery\.zen\.ping\.unicast\.hosts: \["127\.0\.0\.1:9300"\]$/ }
end

describe file(logging_file) do
  it { should exist }
  it { should be_file }
  it { should be_mode 640 }
  it { should be_owned_by config_owner }
  it { should be_grouped_into config_group }
  # No custom changes at this time
end

describe service(service_name) do
  it { should be_running }
  it { should be_enabled }
end

describe port(9200) do
  it { should be_listening.on('::').with('tcp6') }
  it { should_not be_listening.with('udp') }
end

describe port(9300) do
  it { should be_listening.on('::').with('tcp6') }
  it { should_not be_listening.with('udp') }
end
