# xkb-lpa-i3

**xkb-lpa-i3** is a script that automatically switches keyboard layouts based on the active window in the i3 window manager.

## Features

- Automatically changes keyboard layout per application.
- Works with i3 window manager.
- Uses `xdotool` and `xkb-switch`.
- Stores layout rules in a configuration file.

## Installation

If available in AUR:

```bash
yay -S xkb-lpa-i3
```
Or build manually:

```bash
git clone https://github.com/PingerHD/xkb-lpa-i3.git
cd xkb-lpa-i3
makepkg -si
```

## Dependencies

- i3-wm
- xdotool
- xkb-switch
- bash

## Usage

Simply run:

```bash
xkb-lpa-i3
```

## License

MIT License © Pinger

## Contact

[GitHub Repository](https://github.com/PingerHD/xkb-lpa-i3)
