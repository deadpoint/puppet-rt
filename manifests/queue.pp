#
# Definition: rt::queue
#
# Add a request-tracker queue
#
# Notes: queues cannot be removed, only disabled from the gui
#
#
define rt::queue (
    $ensure         = present,
    $description    = "",
    $reply_email    = "",
    $comment_email  = ""
    ) {
    include rt
    include rt::params

    validate_re($ensure, '^present$',
        "${ensure} is not valid. Allowed values are 'present' only.")

    exec { "rt_queue_add_${name}":
        command => "rt create -t queue set name=\"${name}\" description=\"${description}\" CorrespondAddress=\"${reply_email}\" CommentAddress=\"${comment_email}\"",
        unless  => "rt show -t queue \"${name}\" | grep ^Name: > /dev/null",
        require => Class["rt::tool"]
    }
}
