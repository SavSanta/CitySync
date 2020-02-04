#!/usr/bin/env tclsh

set filename [open [lindex $argv 0] "r"]
set tempfile [open [string cat "/tmp/temp-" [file tail [lindex $argv 0]]] "w"]
set lineno 0

while {[gets $filename line] >= 0} {
    set lineno [expr {$lineno + 1}]

    set splitted [split $line ,]
    set col0 [lindex $splitted 0]
    set col3 [lindex $splitted 3]

    if {[regexp {^[^0-9]} $col3]} {
	      puts "Match found! on $lineno ---> $col3"
        set col0 [string cat ZZIGNORE $col0]
        puts "Converted match to $col0"
        set splitted [lreplace $splitted 0 0 $col0]
      }

     set line [join $splitted ","]
     puts $tempfile $line

}

close $filename
close $tempfile

