# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Razer devices configurator"
HOMEPAGE="https://github.com/z3ntu/RazerGenie"
SRC_URI="https://github.com/z3ntu/RazerGenie/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libopenrazer
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5"
BDEPEND="dev-qt/linguist-tools:5
	virtual/pkgconfig"
