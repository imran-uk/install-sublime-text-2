#!/usr/bin/env bash

## TODO
#
# * enable the version number to be supplied as first argument
#
# * convert to perl using getopts
#
# * add usage help with --help?

# NOTE if the latest version changes then update it here
SUBLIME_TEXT_VERSION="2.0.2"

SUBLIME_TEXT="https://download.sublimetext.com/Sublime%20Text%20${SUBLIME_TEXT_VERSION}%20x64.tar.bz2"
SYMLINK_PATH="$HOME/.local/bin"
INSTALL_PATH="$HOME/.local/opt"
TEMP_FILE=$(mktemp)

if [ ! -d "$INSTALL_PATH" ]; then
  echo "Creating install path at [$INSTALL_PATH]"
  mkdir $INSTALL_PATH
fi

echo "Downloading Sublime Text 2 version [$SUBLIME_TEXT_VERSION]"
curl --output $TEMP_FILE $SUBLIME_TEXT

echo "Extracting to [$INSTALL_PATH]"
tar -xjf $TEMP_FILE -C $INSTALL_PATH

if [ ! -d "$SYMLINK_PATH" ]; then
  echo "Creating symlink path at [$SYMLINK_PATH]"
  mkdir $SYMLINK_PATH
fi

echo "Creating symlink..."
ln -sf "$INSTALL_PATH/Sublime Text 2/sublime_text" $SYMLINK_PATH

echo "Setting icon..."
cp "$INSTALL_PATH/Sublime Text 2/Icon/128x128/sublime_text.png" "$HOME/.icons"

echo "Setting XDG shortcut..."
DESKTOP_FILE="[Desktop Entry]
Version=1.0
Name=Sublime Text
Type=Application
Comment=GUI Text Editor
StartupNotify=true
MimeType=text/plain;
Terminal=false
Exec=$HOME/.local/bin/sublime_text %U
Icon=sublime_text.png
Categories=TextEditor;Utility;
GenericName=Sublime Text"

echo "$DESKTOP_FILE" > "$HOME/.local/share/applications/sublime_text.desktop";

echo "Install done"
