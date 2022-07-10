#!/usr/bin/nu

# Hook to add each active shell's working directory to zoxide
export def __zoxide_hook [] {
    shells |
        where active == true |
        where ($it.path | path exists) |
        each {|it| zoxide add $it.path }
}

# Jump to directory that matches the given query
export def-env z [...query:string] {
    let path = if ($query | length) == 0 {
        '~'
    } else if ($query | length) == 1 && ($query.0 == '-' || ($query.0 | path expand | path exists)) {
        $query.0
    } else {
        zoxide query --exclude (pwd) -- $query | str trim -r -c (char newline)
    };
    cd $path
}

# Jump to directory that matches the given query or show a prompt if uncertain
export def-env zi [...query:string] {
    let path = if ($query | length) == 1 && ($query.0 == '-' || ($query.0 | path expand | path exists)) {
        $query.0
    } else {
        zoxide query -i -- $query | str trim -r -c (char newline)
    };
    cd $path
}
