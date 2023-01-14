

proc <| {args} {
  set pos [lindex [lsearch -all $args "<|"] end]

  if {$pos eq ""} {
    tailcall {*}$args
  } else {
    set command [lrange $args $pos+1 end]
    set result  [uplevel 1 $command] 
    set pipeline [lrange $args 0 $pos-1]
    tailcall <| {*}$pipeline $result
  }
}

@test "test-pipeline" "" {
  set i 1
  <| incr i <| set _ 4
} 5

@test "test-pipeline-nopipe" "" {
  set i 1
  <| incr i
} 2
