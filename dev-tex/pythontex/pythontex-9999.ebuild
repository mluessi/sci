# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/envlab/envlab-1.2-r1.ebuild,v 1.18 2012/05/09 17:16:08 aballier Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit latex-package python-single-r1 git-2

DESCRIPTION="Fast Access to Python from within LaTeX"
HOMEPAGE="https://github.com/gpoore/pythontex"
EGIT_REPO_URI="https://github.com/gpoore/pythontex.git"
SRC_URI=""


SLOT="0"
LICENSE="LPPL-1.3 BSD"
KEYWORDS=""
IUSE="highlighting"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="app-text/texlive
	${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	dev-texlive/texlive-xetex
	>=dev-python/matplotlib-1.2.0[${PYTHON_USEDEP}]
	highlighting? ( dev-python/pygments[${PYTHON_USEDEP}] )"

src_prepare() {
	S="${WORKDIR}/${P}/${PN}"
	cd ${S}
	rm pythontex.sty || die "Could not remove pre-compiled pythontex.sty!"
}

src_compile() {
	pwd
	ebegin "Compiling ${PN}"
	latex ${PN}.ins extra >${T}/build-latex.log  || die "Building style from ${PN}.ins failed"
	eend
}

src_install() {
	python_optimize .
	if python_is_python3; then 
		#python_scriptinto /usr/share/texmf-site/scripts/${PN}/
		python_newscript pythontex3.py pythontex.py 
		python_newscript depythontex3.py depythontex.py
	else	python_newscript pythontex2.py pythontex.py
		python_doscript pythontex_2to3.py
		python_newscript depythontex2.py depythontex.py
	fi
	
	python_domodule "${S}"/pythontex_engines.py "${S}"/pythontex_utils.py

	insinto /usr/share/texmf-site/tex/latex/pythontex/
	doins "${S}"/pythontex.sty
	
	insinto /usr/share/texmf-site/source/latex/pythontex/
	doins "${S}"/pythontex.dtx "${S}"/pythontex.ins	

	latex-package_src_install

	dodoc README
	mktexlsr
}
