# Bash

### .bashrc_custom

Custom bash aliases and functions. These are automatically pulled in via the `setupSystem` script in the root of this repository.

### checkmem

I've delt RAM problems where it would max-out seemingly out of nowhere. This script shows the available RAM on a 5 second loop interval. If RAM falls below 1 GB, an alert via a Gnome notification is pushed (`notify-send`). I'm a Firefox user, so if it falls below 200 MB, Firefox is automatically killed before being restarted after 3 seconds. I find restarting Firefox frees up a couple GB.

TODO: Get notifications to replace each other instead of stacking up.
