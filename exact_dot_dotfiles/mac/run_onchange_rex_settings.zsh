#!/usr/bin/env zsh

set -eu

defaults write com.superlogical.rex Workspace.appIcon -string dark
defaults write com.superlogical.rex Workspace.appIconVisibility -string dockAndMenuBar
defaults write com.superlogical.rex Workspace.appearance -string dark
defaults write com.superlogical.rex Workspace.darkThemeID -string ink-meridian
defaults write com.superlogical.rex Workspace.focusFollowsMouse -bool false
defaults write com.superlogical.rex Workspace.inactivePaneFadeMode -string both
defaults write com.superlogical.rex Workspace.interfaceStyle -string useTheme
defaults write com.superlogical.rex Workspace.lightThemeID -string lavender-postcard
defaults write com.superlogical.rex Workspace.showsPaneHeaders -bool false
defaults write com.superlogical.rex Workspace.sidebarCollapsed -bool false
defaults write com.superlogical.rex Workspace.sidebarPosition -string left
defaults write com.superlogical.rex Workspace.tabIconCount -int 0
defaults write com.superlogical.rex Workspace.tabIconTintMode -string off
defaults write com.superlogical.rex Workspace.tabStyle -string horizontal
defaults write com.superlogical.rex Workspace.tabsFillAvailableSpace -bool false
defaults write com.superlogical.rex Workspace.terminalCellHeightPercent -float 64.0
defaults write com.superlogical.rex Workspace.terminalCopyOnSelect -bool true
defaults write com.superlogical.rex Workspace.terminalFontName -string 'DankMono Nerd Font Plus Font Awesome Plus Material Design Icons'
defaults write com.superlogical.rex Workspace.terminalFontPointSize -float 13.0
defaults write com.superlogical.rex Workspace.terminalFontSmoothing -bool false
defaults write com.superlogical.rex Workspace.terminalPaddingColor -string extend
defaults write com.superlogical.rex Workspace.tintsPanesWithProgramBackground -bool true
defaults write com.superlogical.rex Workspace.usesStandardInactiveWindowPaneStyles -bool true
defaults write com.superlogical.rex rex.agents.names-sessions -bool false
defaults write com.superlogical.rex rex.server.automatic-restart-enabled -bool true
defaults write com.superlogical.rex rex.server.block-plugin-reload-enabled -bool false
defaults write com.superlogical.rex rex.server.run-mode -string bundled
defaults write com.superlogical.rex rex.server.web-client-origin-patterns -array https://rex.superlogical.com
