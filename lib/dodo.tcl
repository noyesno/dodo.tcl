
package provide dodo.tcl 0.1

proc proc/n {name argv body} {

    proc [format "%s/%d" $name [llength $argv]] $argv $body
    
    proc $name {args} {
        uplevel 1 [format "%s/%d" [lindex [info level 0] 0] [llength $args]] $args
    }

}

