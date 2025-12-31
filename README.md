# KDE Displays Switcher

A lightweight Bash script for switching between display presets in KDE Plasma using `kscreen-doctor`.

## Features

- 🖥️ **Multiple Display Presets** - Define and switch between different display configurations
- 🔄 **Cycle Mode** - Automatically cycle through all available presets
- 🎨 **GUI Mode** - Interactive preset selection using `kdialog`
- ⚙️ **Full kscreen-doctor Support** - Configure resolution, scaling, rotation, position, and more
- 📝 **Simple INI Configuration** - Easy-to-read and edit configuration format

## Dependencies

- **KDE Plasma** (with `kscreen-doctor`)
- **Bash** (version 4.0+)
- **kdialog** (optional, for GUI mode)

## Installation

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/mykola-shevchenko-dev/kde-displays-switcher
cd kde-displays-switcher
```

2. Make the script executable:
```bash
chmod +x kde-displays-switcher.sh
```

3. (Optional) Create a symlink to use it system-wide:
```bash
sudo ln -s "$(pwd)/kde-displays-switcher.sh" /usr/local/bin/kde-displays-switcher
```

4. Create your configuration file:
```bash
cp config-example.ini ~/.config/displays-switcher/config.ini
```

### Configuration

The script looks for configuration in the following location: `~/.config/displays-switcher/config.ini`

Edit the configuration file to define your display presets:

```ini
[laptop]
output.DP-2.disable
output.eDP-2.enable
output.eDP-2.primary
output.eDP-2.scale.1
output.eDP-2.mode.1920x1080@60
output.eDP-2.position.0,0
output.eDP-2.rotation.normal

[all]
output.DP-2.enable
output.DP-2.primary
output.DP-2.scale.1
output.DP-2.mode.2560x1440@144
output.DP-2.position.0,0
output.DP-2.rotation.normal
output.eDP-2.enable
output.eDP-2.scale.1
output.eDP-2.mode.1920x1080@60
output.eDP-2.position.760,1440
output.eDP-2.rotation.normal

[presentation]
output.eDP-2.disable
output.DP-2.enable
output.DP-2.primary
output.DP-2.scale.1.5
output.DP-2.mode.1920x1080@60
output.DP-2.position.0,0
output.DP-2.rotation.normal
```

### Finding Your Display Names

To find your display output names, run:
```bash
kscreen-doctor -o
```

## Usage

### Basic Usage

Switch to a specific preset:
```bash
./kde-displays-switcher.sh -p laptop
./kde-displays-switcher.sh -p all
```

### Cycle Through Presets

Cycle to the next preset:
```bash
./kde-displays-switcher.sh
```

This is useful for keyboard shortcuts - each execution switches to the next preset in your configuration.

### GUI Mode

Open an interactive dialog to select a preset:
```bash
./kde-displays-switcher.sh -d
```

### Command-line Options

- `-p PRESET` - Switch to the specified preset
- `-d` - Show GUI dialog for preset selection
- `-v` - Display version number

## Keyboard Shortcuts

You can bind the script to keyboard shortcuts in KDE:

1. Open **System Settings** → **Shortcuts** → **Custom Shortcuts**
2. Create a new **Global Shortcut** → **Command/URL**
3. Set the command to:
   - Cycle mode: `/path/to/kde-displays-switcher.sh`
   - GUI mode: `/path/to/kde-displays-switcher.sh -d`
   - Specific preset: `/path/to/kde-displays-switcher.sh -p laptop`

Example shortcuts:
- `Meta+P` → Cycle through presets
- `Meta+Shift+P` → Show GUI dialog

## Supported Display Options

The script supports all `kscreen-doctor` options:

- `output.NAME.enable` - Enable the display
- `output.NAME.disable` - Disable the display
- `output.NAME.primary` - Set as primary display
- `output.NAME.mode.WIDTHxHEIGHT@RATE` - Set resolution and refresh rate
- `output.NAME.position.X,Y` - Set display position
- `output.NAME.scale.FACTOR` - Set scaling factor (1, 1.25, 1.5, 2, etc.)
- `output.NAME.rotation.DIRECTION` - Set rotation (normal, left, right, inverted)

## Uninstallation

```bash
# Remove symlink (if created)
sudo rm /usr/local/bin/kde-displays-switcher

# Remove configuration
rm ~/.config/displays-switcher/config.ini

# Remove the repository
cd ..
rm -rf kde-displays-switcher
```

## License

GNU General Public License v3.0 - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
