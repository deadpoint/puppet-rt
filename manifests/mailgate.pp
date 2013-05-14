#
class rt::mailgate (
    $ensure = 'present'
     ) {
    include rt::params
    #
    package { "rt-mailgate":
        name    => $rt::params::rt_mailgate,
        ensure  => $ensure,
    }
}
