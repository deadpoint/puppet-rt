#
# Class: rt
#
# This class manages request-tracker
#
class rt (
    $dbtype,
    ) {

    include rt::params

    #
    validate_re($dbtype, '^(mysql|oracle|postgres|sqlite)$',
    "${dbtype} is not a supported request-tracker database engine" )

    #
    case $dbtype {
        'mysql':    { $db_pkg = "$rt::params::rt_db_mysql" }
        'oracle':   { $db_pkg = "$rt::params::rt_db_oracle" }
        'postgres': { $db_pkg = "$rt::params::rt_db_postgres" }
        'sqlite':   { $db_pkg = "$rt::params::rt_db_sqlite" }
        default:    { fail("Unsupported request-tracker database package, $db, for $::osfamily") }
    }
    #
    package { "rt":
        name    => "$rt::params::rt_name",
        ensure  => present
    }
    package { "rt-db":
        name    => $db_pkg,
        ensure  => present
    }
    #
    file { "rt_dir":
        ensure  => directory,
        path    => $rt::params::rt_dir,
        owner   => root,
        group   => root,
        mode    => 0755,
        require => Package["rt"],
    }
    file { "RT_SiteConfig.pm":
        ensure  => present,
        path    => "$rt::params::rt_dir/RT_SiteConfig.pm",
        owner   => root,
        group   => $rt::params::rt_grp,
        mode    => 0640,
        require => Package["rt"]
    }
}
