#
class rt::tool (
    $rt_user,
    $rt_passwd,
    $rt_server
    ) {
    include rt::params
    file { "$rt::params::rt_tool_cnf":
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 0600,
        content => template("rt/rtrc.erb"),
    }
}
