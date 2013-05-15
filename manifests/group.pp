#
# Definition: rt::group
#
# Add a request-tracker group
#
# Groups cannot be deleted only disable
#
define rt::group (
    $ensure         = present,
    $description    = "",
    ) {
    include rt
    include rt::params

    validate_re($ensure, '^present$',
        "${ensure} is not valid. Allowed values are 'present' only.")

    exec { "rt_group_${name}":
        command => "rt create -t groups set name=\"${name}\" description=\"${description}\"",
        unless  => "rt show -t groups \"${name}\" | grep ^Name: > /dev/null",
        require => Class["rt::tool"]
    }
}
