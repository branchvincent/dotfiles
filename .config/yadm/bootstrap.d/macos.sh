# shellcheck shell=bash
#
# Update macOS preferences
#
# References
# - Inspiration: https://mths.be/macos

### General ###
chflags nohidden ~/Library                                       # FIXME: not working on catalina
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark   # Dark mode
defaults write com.apple.finder QLEnableTextSelection -bool true # Enable copy from quicklook
launchctl load ~/Library/LaunchAgents/environment.plist          # Load launch agent

### Desktop ###
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Mojave Night.jpg"'

### Dock ###
dockutil --no-restart --remove all
dockutil --no-restart --add /System/Applications/Calendar.app
dockutil --no-restart --add /System/Applications/Mail.app
dockutil --no-restart --add /System/Applications/Messages.app
dockutil --no-restart --add /Applications/Slack.app
dockutil --no-restart --add /Applications/Spotify.app
dockutil --no-restart --add /Applications/Google\ Chrome.app
dockutil --no-restart --add /Applications/Visual\ Studio\ Code.app
dockutil --no-restart --add /Applications/iTerm.app
dockutil --no-restart --add /System/Applications/System\ Preferences.app
dockutil --no-restart --add ~/Documents --sort name --display folder --view list
dockutil --no-restart --add ~/Downloads --sort dateadded --display folder --view fan

### iTerm2 ###
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2.plist DynamicProfilesPath -string "~/.config/iterm2"
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2"

### Mission Control ###
defaults write com.apple.dock wvous-tl-corner -int 10 # Top left: Display sleep
defaults write com.apple.dock wvous-tr-corner -int 12 # Top right: Notification center
defaults write com.apple.dock magnification -int 1
defaults write com.apple.dock orientation -string bottom

### Siri ###
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

### Software Update ###
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 # Check for updates daily

### Trackpad ###
defaults write -g com.apple.trackpad.scaling 3 # Max trackpad speed

# Restart affected apps
for app in Dock Finder; do
    killall "$app"
done
