# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )

inherit python-any-r1 scons-utils

DESCRIPTION="Provides settings to X11 applications via the XSETTINGS specification"
HOMEPAGE="https://github.com/derat/xsettingsd"
SRC_URI="https://github.com/derat/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_compile() {
    escons
}

src_install() {
    dobin xsettingsd dump_xsettings
    doman xsettingsd.1 dump_xsettings.1
}
