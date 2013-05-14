#
# Class rt::repo::zypprepo sets up zypper package repositories
#
class rt::repo::zypprepo {
    case $::operatingsystem {
        "opensuse": { $repo_name = "openSUSE" }
        "sles":     { $repo_name = "SLE" }
        default:    { fail("Unsupport operatingsystem: $::operatingsystem") }
    }
    zypprepo { "devel:languages:perl":
        baseurl     => "http://download.opensuse.org/repositories/devel:/languages:/perl/${repo_name}_${::lsbdistrelease}",
        enabled     => 1,
        gpgcheck    => 0,
        autorefresh => 0,
    }
}
