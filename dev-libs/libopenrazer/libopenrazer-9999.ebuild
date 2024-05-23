# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/z3ntu/${PN}.git"

inherit git-r3 meson

DESCRIPTION="Qt wrapper around the D-Bus API from OpenRazer"
HOMEPAGE="https://github.com/z3ntu/libopenrazer"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtxml:5"
BDEPEND="virtual/pkgconfig"
