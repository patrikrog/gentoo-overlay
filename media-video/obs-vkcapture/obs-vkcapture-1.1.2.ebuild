# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_REMOVE_MODULES_LIST=( FindFreetype )

inherit xdg cmake-multilib

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nowrep/obs-vkcapture"
else
	SRC_URI="https://github.com/nowrep/obs-vkcapture/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="OBS Linux Vulkan/OpenGL game capture"
HOMEPAGE="https://github.com/nowrep/obs-vkcapture"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

BDEPEND="
	dev-util/vulkan-headers
	media-libs/shaderc
	media-libs/vulkan-loader
	x11-libs/libdrm
"
RDEPEND="
	media-libs/libglvnd
	>=media-video/obs-studio-27[wayland]
	x11-libs/libdrm
	x11-libs/libxcb:=
"

src_unpack() {
	default

	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
}

src_configure() {
	local mycmakeargs
	if ! multilib_is_native_abi; then
		local mycmakeargs+=(
			-DBUILD_PLUGIN=OFF
		)
	fi
	cmake-multilib_src_configure
}

src_compile() {
	cmake-multilib_src_compile
}
