# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Move Dock to the left
defaults write com.apple.dock orientation -string "right"

# Enable auto-hide
defaults write com.apple.dock autohide -bool true

# Automatically hide the menu bar in macOS for all apps
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Disable natural scrolling
defaults write -g com.apple.swipescrolldirection -bool false

# Scroll wheel scaling. Keep this at the macOS default; a stray 0.125 was found
# on this machine and it aggravates the macOS 26 discrete-wheel bug (see
# linearmouse/install.sh). -1 does NOT disable scroll acceleration.
defaults write -g com.apple.scrollwheel.scaling -float 0.4

# Fast animations
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock showhidden -bool true

# Apply changes
killall Dock
killall Finder
killall SystemUIServer
