function glob --description 'cmd rich glob'
    if test -z $argv
        return 1
    end
    set fd_args
    for arg in $argv
        set -a fd_args "-g" "$arg"
    end
    set fd_result (fd -i --full-path $fd_args)
    echo $fd_result
    if test (count $fd_result)
        return 1
    end
end
