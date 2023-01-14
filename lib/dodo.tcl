
package provide dodo.tcl 0.1

proc @doc {args} {
  uplevel 1 [lrange $args 1 end]
}

proc @usage {args} {
  uplevel 1 [lrange $args 1 end]
}

proc proc/n {name argv body} {

    proc [format "%s/%d" $name [llength $argv]] $argv $body
    
    proc $name {args} {
        uplevel 1 [format "%s/%d" [lindex [info level 0] 0] [llength $args]] $args
    }

}


proc lfirst {aList} { lindex $aList 0 }
proc lsecond {alist} { lindex $aList 1 }
proc llast {aList} { lindex $aList end }


@doc {
  list comprehension
} \
proc lcomp {xExpr xVar xList {xFilter 1}} {
    lmap $xVar $xList [join [list \
            [list if $xFilter {} else continue] \
	    [list expr $xExpr] \
    ] "\n"]
}


proc infix {a cmdName b} {
    uplevel 1 [list $cmdName $a $b]
}


proc lreduce {aList xVar resVar aExpr} {
    set $resVar 0
    foreach $xVar $aList {
        set $resVar [expr $aExpr]
    }
    return [set $resVar]
}
