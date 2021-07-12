#!/usr/bin/env bash

set -euo pipefail

# We can't have this line because the default version of bash on mac os too old
# shopt -s inherit_errexit

# With thanks/credit to https://github.com/docker/for-mac/issues/2359#issuecomment-853420567

# Update brew to make sure we're using the latest formulae
brew update

###############################
# General
brew install bash
brew install gsed
brew install findutils
ln -s /usr/local/bin/gsed /usr/local/bin/sed
ln -s /usr/local/bin/gfind /usr/local/bin/find
hash -r
which sed
which find

###############################
# Docker
brew install --cask docker
# allow the app to run without confirmation
xattr -d -r com.apple.quarantine /Applications/Docker.app

# preemptively do docker.app's setup to avoid any gui prompts
sudo /bin/cp /Applications/Docker.app/Contents/Library/LaunchServices/com.docker.vmnetd /Library/PrivilegedHelperTools

# the plist we need used to be in /Applications/Docker.app/Contents/Resources, but
# is now dynamically generated. So we dynamically generate our own
sudo tee "/Library/LaunchDaemons/com.docker.vmnetd.plist" > /dev/null <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
 <key>Label</key>
 <string>com.docker.vmnetd</string>
 <key>Program</key>
 <string>/Library/PrivilegedHelperTools/com.docker.vmnetd</string>
 <key>ProgramArguments</key>
 <array>
  <string>/Library/PrivilegedHelperTools/com.docker.vmnetd</string>
 </array>
 <key>RunAtLoad</key>
 <true/>
 <key>Sockets</key>
 <dict>
  <key>Listener</key>
  <dict>
   <key>SockPathMode</key>
   <integer>438</integer>
   <key>SockPathName</key>
   <string>/var/run/com.docker.vmnetd.sock</string>
  </dict>
 </dict>
 <key>Version</key>
 <string>59</string>
</dict>
</plist>

EOF

sudo /bin/chmod 544 /Library/PrivilegedHelperTools/com.docker.vmnetd
sudo /bin/chmod 644 /Library/LaunchDaemons/com.docker.vmnetd.plist
sudo /bin/launchctl load /Library/LaunchDaemons/com.docker.vmnetd.plist

# Random sleep for good measure
sleep 15

# Run
[[ $(uname) == 'Darwin' ]] || { echo "This function only runs on macOS." >&2; exit 2; }

echo "-- Starting Docker.app, if necessary..."

open -g -a /Applications/Docker.app || exit

# Wait for the server to start up, if applicable.
i=0
while ! docker system info &>/dev/null; do
  (( i++ == 0 )) && printf %s '-- Waiting for Docker to finish starting up...' || printf '.'
  sleep 1
done
(( i )) && printf '\n'

echo "-- Docker is ready."
