function udisk --description 'cmd toggle udisks2 /dev asd .iso'
    # Function generated via https://wiki.archlinux.org/title/Udisks
    # TODO: 
    # 1. Add iso connection
    # 2. Add list non-default drives with mount path (into /media or so) something like "/dev/sdd1 -> /media/sdd1". Also change mount dir name
    #set dir_path = /media/(basename $argv[1])
    #if test (path extension $argv[1]) = .iso
    #    if not udisksctl loop-setup -r -f $argv[1] > /dev/null 
    if not udisksctl mount -b $argv[1] 2>/dev/null
        udisksctl unmount -b $arv[1] 2>/dev/null
    end
    return $status
end
