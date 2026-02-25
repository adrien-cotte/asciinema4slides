#!/bin/bash

# Get ASCIINEMA function
# Note: not visible in asciinema
source etc/config.sh

# Visible in asciinema
ASCIINEMA echo Hello

# Not visible
MSG="Bye"

# Visible
ASCIINEMA echo $MSG
