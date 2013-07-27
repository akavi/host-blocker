Host Blocker
===========

A super simple script to uncomment entries in your hosts file.

Why?
----

I spend a lot of time editing domains from my hosts file: mostly to block sites that are distracting (facebook, youtube, reddit, etc).
Occasionally however, I need to unblock a site (e.g., to look up a friend's contact info on Facebook) -- I do this by commenting out the line in the hosts file.

This script re-blocks domains by uncommenting existing entries.

There's no unblocking script -- if I want to unblock a distraction, I still have to do it manually.

Usage
-----

    sudo ./blocker.rb facebook.com

This will search your hosts file, find any commented line matching ```facebook.com``` or ```www.facebook.com```, and uncomment that line.
It will also print out a report of the number of lines blocked.

Note: on Ubuntu, the hosts file is at ```/etc/hosts```, so you may need to edit that manually.

TODO
----

  1. Allow multiple domain name arguments to be passed
  2. Append mode: if a domain name isn't in the hosts file already, append to it.
  3. Auto detection of location of hosts file based on OS.
