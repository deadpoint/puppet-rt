#
class rt::params {
  case $::operatingsystem {
    "OpenSuSE", "SLES", "SLED", "SuSE":  {
      $rt-pkg = 'request-tracker'
      $rt-db = ""
      $rt-mailgate = ""
      #
      zypprepo { "devel:languages:perl (request-tracker)":
        baseurl => "http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_${::lsbdistrelease}",
        enable => 1,
        gpgcheck => 0,
        autorefresh => 0,
        }
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}

