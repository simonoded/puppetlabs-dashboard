# Class: dashboard::params
#
# This class configures parameters for the puppet-dashboard module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class dashboard::params {

  $dashboard_ensure                 = 'present'
  $dashboard_user                   = 'puppet-dashboard'
  $dashboard_group                  = 'puppet-dashboard'
  $dashboard_password               = 'changeme'
  $dashboard_db                     = 'dashboard_production'
  $dashboard_charset                = 'utf8'
  $dashboard_environment            = 'production'
  $dashboard_site                   = $::fqdn
  $dashboard_port                   = '8080'
  $passenger                        = false
  $mysql_root_pw                    = 'changemetoo'
  $rails_base_uri                   = '/'
  $rack_version                     = '1.1.2'
  $dashboard_ca_server              = 'puppet'
  $dashboard_ca_port                = '8140'
  $dashboard_inventory_service      = false
  $dashboard_inventory_server       = 'puppet'
  $dashboard_inventory_port         = '8140'
  $dashboard_file_bucket_diff       = false
  $dashboard_file_bucket_server     = 'puppet'
  $dashboard_file_bucket_port       = '8140'
  $dashboard_read_only_mode         = false
  $dashboard_timezone               = 'Pacific Time (US & Canada)'

  case $::osfamily {

    'RedHat': {
      $dashboard_config       = '/etc/sysconfig/puppet-dashboard'
      $dashboard_service      = ['puppet-dashboard','puppet-dashboard-workers']
      $dashboard_package      = 'puppet-dashboard'
      $dashboard_root         = '/usr/share/puppet-dashboard'
    }

    'Debian': {
      $dashboard_config          = '/etc/default/puppet-dashboard'
      $dashboard_service         = 'puppet-dashboard'
      $dashboard_package         = 'puppet-dashboard'
      $dashboard_root            = '/usr/share/puppet-dashboard'
      $dashboard_workers_service = 'puppet-dashboard-workers'
      $dashboard_workers_config  = '/etc/default/puppet-dashboard-workers'
      $dashboard_num_workers     = '4'
      $dashboard_workers_start   = 'yes'
      $mysql_package_provider    = 'aptitude'
      $ruby_mysql_package        = 'libmysql-ruby1.8'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}

