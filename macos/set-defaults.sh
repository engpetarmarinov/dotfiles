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

# Fast animations
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock showhidden -bool true

# Apply changes
killall Dock
killall Finder
killall SystemUIServer
