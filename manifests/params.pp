# Class: rt::params
#
# This class manages RT paramaters
#
# Parameters:
# - rt_name - the name of the package
# - rt_db_* - the name of the database package
# - ext_packages - RT extension packages
#
class rt::params {
    case $::osfamily {
        "Suse":  {
            $rt_name        = 'request-tracker'
            $rt_dir         = "/etc/request-tracker"
            $rt_mailgate    = "${rt_name}-mailgate"
            $rt_grp         = "www"
            $rt_db_mysql    = "${rt_name}-db-mysql"
            $rt_db_oracle   = "${rt_name}-db-oracle"
            $rt_db_postgres = "${rt_name}-db-postgres"
            $rt_db_sqlite   = "${rt_name}-db-sqlite"
            $rt_tool_cnf    = "/root/.rtrc"
            $manage_repo    = true
            #
            $ext_packages   = {
                'assettracker'          => 'perl-RTx-AssetTracker',
                'jsgantt'               => 'perl-RT-Extension-JSGantt',
                'activityreports'       => 'perl-RT-Extension-ActivityReports',
                'externalauth'          => 'perl-RT-Authen-ExternalAuth',
                'quickupdate'           => 'perl-RT-Extension-QuickUpdate',
                'customfieldonupdate'   => 'perl-RT-Extension-CustomFieldsOnUpdate',
                'sla'                   => 'perl-RT-Extension-SLA',
                'commandbymail'         => 'perl-RT-Extension-CommandByMail',
                'nagios'                => 'perl-RT-Extension-Nagios',
                'cookieauth'            => 'perl-RT-Authen-CookieAuth',
                'ldapimport'            => 'perl-RT-Extension-LDAPImport',
                'mergeusers'            => 'perl-RT-Extension-MergeUsers',
                'mobileui'              => 'perl-RT-Extension-MobileUI',
                'repliestoresolved'     => 'perl-RT-Extension-RepliesToResolved',
            }
        }
        default: { fail("Unsupported platform: ${::osfamily}") }
    }
    #
    if ($manage_repo) {
        case $::osfamily {
            "Suse":     { class { "rt::repo::zypprepo": } }
            default:    { fail("Unsupported osfamily: ${::osfamily} for module ${module_name}") }
        }
    }
}
