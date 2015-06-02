VERSION = 1.0.5

DESTDIR = /usr/local
DEFAULT_DROID_VER = kk

all:

install:
	install -d ${DESTDIR}/bin
	for droidver in ics jb kk lp; do \
		install $${droidver}-gcc ${DESTDIR}/bin/$${droidver}-gcc; \
		for cmd in ar as c++ g++ ld nm objcopy objdump ranlib strip; do \
			if [ -f "${DESTDIR}/bin/$${droidver}-$$cmd" ]; then \
				/bin/rm ${DESTDIR}/bin/$${droidver}-$$cmd; \
			fi; \
			/bin/ln -s $${droidver}-gcc "${DESTDIR}/bin/$${droidver}-$$cmd"; \
		done \
	done
	/bin/rm "${DESTDIR}/bin/droid-gcc"
	/bin/ln -s ${DEFAULT_DROID_VER}-gcc "${DESTDIR}/bin/droid-gcc"
	for cmd in ar as c++ g++ ld nm objcopy objdump ranlib strip; do \
		if [ -f "${DESTDIR}/bin/droid-$$cmd" ]; then \
			/bin/rm ${DESTDIR}/bin/droid-$$cmd; \
		fi; \
		/bin/ln -s droid-gcc "${DESTDIR}/bin/droid-$$cmd"; \
	done

package:
	@-/bin/rm -rf droid-wrapper-${VERSION}
	mkdir droid-wrapper-${VERSION}
	cp droid-gcc Makefile \
	  README README.ja INSTALL AUTHORS COPYING ChangeLog \
	  droid-wrapper-${VERSION}/
	tar cvzf droid-wrapper-${VERSION}.tar.gz droid-wrapper-${VERSION}


