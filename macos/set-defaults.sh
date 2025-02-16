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

# Apply changes
killall Dock
killall Finder
killall SystemUIServer
