#!/usr/bin/env tclsh

# geocode_badaddress_marker.tcl
# Separates potentially bad addresses out by prepending the first column of CSV with ZZZIGNORE.
# Author:    Ru Uba (SavSanta)
# Created:   2.04.2020

set filename [open [lindex $argv 0] "r"]
# TODO use environment temp variable for platform agnosticism
set tempfile [open [string cat "/tmp/temp-" [file tail [lindex $argv 0]]] "w"]
set lineno 0

while {[gets $filename line] >= 0} {
    set lineno [expr {$lineno + 1}]

# TODO use the package require csv so that can split better conditions
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

