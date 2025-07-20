set -eu

BASEDIR=$(cd $(dirname $0); pwd)
DISTRO=$1
BUILDPLATFORM=$2
TARGETPLATFORM=$3

. $BASEDIR/vars.sh

TARBALL_URL=https://github.com/tkmsst/recfsusb2n/tarball/master

curl $TARBALL_URL -fsSL | tar -xz --strip-components=1
cd src
if [ "$DISTRO" = alpine ]; then
  sed -i -e '/^LIBS/a LDFLAGS = -static -no-pie' Makefile
fi
make -j $(nproc)
make install
$STRIP /usr/local/bin/recfsusb2n
