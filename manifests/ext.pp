#
# Heavily take from puppetlabs-apache mod.pp
#
define rt::ext (
    $package = undef
    ) {
    $ext = $name
    include rt::params
    $ext_packages = $rt::params::ext_packages
    $ext_package  = $ext_packages[$ext] # 2.6 compatibility hack
    if $package {
        $package_REAL = $package
    } elsif "$ext_package" {
        $package_REAL = $ext_package
    }
    if $package_REAL {
        package { $package_REAL:
            ensure  => present,
            require => Package['rt'],
        }
    }
}
