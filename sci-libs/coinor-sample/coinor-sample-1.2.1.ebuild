# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

MYPN=Sample

DESCRIPTION="COIN-OR Sample models"
HOMEPAGE="https://projects.coin-or.org/svn/Data/Sample"
SRC_URI="http://www.coin-or.org/download/source/Data/${MYPN}-${PV}.tgz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYPN}-${PV}"

src_install() {
	autotools-utils_src_install
	# already installed and empty directories
	rm -rf "${ED}"/usr/share/coin/doc
}
