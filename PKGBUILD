# Maintainer: Pinger <pingerhd@gmail.com>
pkgname=xkb-lpa-i3
pkgver=1.0
pkgrel=1
pkgdesc="Script to set xkb keyboard layout per app for i3wm"
arch=('x86_64')
url="https://github.com/PingerHD/xkb-lpa-i3"
license=('MIT')
depends=('i3-wm' 'xdotool' 'xkb-switch' 'bash')
source=("xkb-lpa-i3.sh")
md5sums=('394e8dddd0cfcd234a5f1588dde19f04')

package() {
    install -Dm755 xkb-lpa-i3.sh "$pkgdir/usr/bin/xkb-lpa-i3"
}

