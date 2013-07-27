=== Host Blocker

A super simple script to uncomment entries in your hosts file.

Usage
-----

    sudo ./blocker.rb facebook.com

This will search your hosts file, find any commented line matching facebook.com or www.facebook.com, and uncomment that line.
It will also print out a report of the number of lines blocked.

Note: on Ubuntu, the hosts file is at ```/etc/hosts```, so you may need to edit that manually.

TODO
----

  1. Allow multiple domain name arguments to be passed
  2. Append mode: if a domain name isn't in the hosts file already, append to it.
  3. Auto detection of location of hosts file based on OS.
