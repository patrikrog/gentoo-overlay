# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
inherit autotools desktop eutils flag-o-matic go-module python-single-r1

EGO_SUM=(
	"github.com/abiosoft/ishell v2.0.0+incompatible"
	"github.com/abiosoft/ishell v2.0.0+incompatible/go.mod"
	"github.com/abiosoft/readline v0.0.0-20180607040430-155bce2042db"
	"github.com/abiosoft/readline v0.0.0-20180607040430-155bce2042db/go.mod"
	"github.com/chzyer/logex v1.1.10"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fatih/color v1.9.0"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/flynn-archive/go-shlex v0.0.0-20150515145356-3f9db97f8568"
	"github.com/flynn-archive/go-shlex v0.0.0-20150515145356-3f9db97f8568/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.3"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.3/go.mod"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.6.0"
	"github.com/sirupsen/logrus v1.6.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.6.1"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190422165155-953cdadca894/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4"
	"golang.org/x/sys v0.0.0-20200212091648-12a6c2dcc1e4/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

DESCRIPTION="A multiple large virtual desktop window manager derived from fvwm"
HOMEPAGE="http://www.fvwm.org/"
MY_PN="${PN}3"
MY_PV="${PV/3./}"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/fvwmorg/${MY_PN}/releases/download/${MY_PV}/${MY_P}.tar.gz \
	${EGO_SUM_SRC_URI}"
KEYWORDS="~amd64 ~x86"
DOCS=( NEWS CHANGELOG.md )

LICENSE="GPL-2 FVWM"
SLOT="0"
IUSE="bidi debug go htmldoc netpbm nls perl png readline rplay svg tk truetype vanilla lock x86-fbsd"

COMMON_DEPEND="
	dev-libs/libbson
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	bidi? ( dev-libs/fribidi )
	go? ( >=dev-lang/go-1.14 )
	png? ( media-libs/libpng )
	readline? (
		sys-libs/ncurses
		sys-libs/readline
	)
	svg? ( gnome-base/librsvg )
	truetype? (
		media-libs/fontconfig
		x11-libs/libXft
	)"

RDEPEND="${PYTHON_DEPS}
	${COMMON_DEPEND}
	dev-lang/perl
	perl? ( tk? (
			dev-lang/tk
			dev-perl/Tk
			>=dev-perl/X11-Protocol-0.56
		)
	)
	rplay? ( media-sound/rplay )
	lock? ( x11-misc/xlockmore )
	userland_GNU? ( sys-apps/debianutils )
	!x86-fbsd? ( netpbm? ( media-libs/netpbm ) )"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	dev-ruby/asciidoctor
	x11-base/xorg-proto"

src_unpack() {
	unpack "${MY_P}".tar.gz
	S="${WORKDIR}/${MY_P}"
	go-module_src_unpack
	ln -s "${PORTAGE_BUILDDIR}/temp/go-proxy" "${S}/bin/FvwmPrompt/vendor" || die "symlink failed"
}

src_prepare() {
	python-single-r1_pkg_setup
	default
	eautoreconf
	sed -i '/^@FVWM_BUILD_GOLANG_TRUE@GOBUILD = $(GOCMD) build/s/$/ -mod=mod/' \
		bin/FvwmPrompt/Makefile.in || die "sed FvwmPrompt failed"
	sed -i '1c#!/usr/bin/env python3' bin/FvwmCommand.in || die "sed FvwmCommand failed"
	sed -i '1c#!/usr/bin/env python3' bin/fvwm-menu-desktop.in || die "sed fvwm-menu-desktop failed"
}

src_configure() {
	# As fvwm3 is in fast development, I think it is right to put --disable-silent-rules for now.
	local myconf="--prefix=/usr --with-imagepath=/usr/include/X11/bitmaps:/usr/include/X11/pixmaps:/usr/share/icons/fvwm \
		--enable-package-subdirs --disable-silent-rules"

	# Recommended by upstream (thomas Adam on IRC #fvwm) for release. Doesn't really matter for live code.
	append-flags -fno-strict-aliasing

	# Signed chars are required.
	use ppc && append-flags -fsigned-char

	use readline && myconf="${myconf} --without-termcap-library"

	myconf="${myconf}
		$(use_enable bidi)
		--enable-mandoc
		$(use_enable go golang)
		$(use_enable nls)
		$(use_enable nls iconv)
		$(use_enable perl perllib)
		$(use_enable png)
		$(use_with readline readline-library)
		$(use_enable svg rsvg)
		$(use_enable truetype xft)
		--docdir=/usr/share/doc/${P}"
	echo ./configure ${myconf}
	./configure ${myconf}
}

src_compile() {
	PREFIX="/usr" emake
	if use htmldoc; then
		for i in doc/bin doc/fvwm3 doc/modules; do
			cd "${S}/${i}"
			for docfile in *.adoc; do
				asciidoctor -a toc -b html5 -d manpage ${docfile}
			done
		done
		cd "${S}"
	fi
}

src_install() {
	make DESTDIR="${D}" prefix="/usr" exec_prefix="/usr" datarootdir="/usr/share" install || die

	dodir /etc/X11/Sessions
	echo "/usr/bin/fvwm3" > "${D}/etc/X11/Sessions/${PN}" || die
	fperms a+x /etc/X11/Sessions/${PN} || die

	python_fix_shebang "${D}"/usr/bin/fvwm-menu-desktop
	python_fix_shebang "${D}"/usr/bin/FvwmCommand
	if use htmldoc; then
		HTML_DOCS=( doc/bin/*.html doc/fvwm3/*.html doc/modules/*.html )
	fi
	einstalldocs
	make_session_desktop fvwm3 /usr/bin/fvwm3
}
