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

1. Clone the repository:
```bash
git clone https://github.com/mykola-shevchenko-dev/kde-displays-switcher
cd kde-displays-switcher
```

2. Install the script system-wide:
```bash
sudo cp displays-switcher.sh /usr/local/bin/displays-switcher
sudo chmod +x /usr/local/bin/displays-switcher
```

3. Create your configuration file:
```bash
mkdir -p ~/.config/displays-switcher
cp config-example.ini ~/.config/displays-switcher/config.ini
```

4. Edit the configuration file to match your display setup:
```bash
nano ~/.config/displays-switcher/config.ini
```

## Configuration

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
displays-switcher -p laptop
displays-switcher -p all
```

### Cycle Through Presets

Cycle to the next preset:
```bash
displays-switcher
```

This is useful for keyboard shortcuts - each execution switches to the next preset in your configuration.

### GUI Mode

Open an interactive dialog to select a preset:
```bash
displays-switcher -d
```

### Command-line Options

- `-p, --preset PRESET` - Switch to the specified preset
- `-d, --dialog` - Show GUI dialog for preset selection
- `-v, --version` - Display version number
- `-h, --help` - Show help message with usage information

## Keyboard Shortcuts

You can bind the script to keyboard shortcuts in KDE:

1. Open **System Settings** → **Shortcuts** → **Custom Shortcuts**
2. Create a new **Global Shortcut** → **Command/URL**
3. Set the command to:
   - Cycle mode: `displays-switcher`
   - GUI mode: `displays-switcher -d`
   - Specific preset: `displays-switcher -p laptop`

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
# Remove script
sudo rm /usr/local/bin/displays-switcher

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
