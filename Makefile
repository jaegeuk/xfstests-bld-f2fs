#
# A simple makefile for xfstests-bld
#

all: xfsprogs-dev xfstests-dev fio quota \
	gce-xfstests.sh kvm-xfstests.sh
	./build-all

xfsprogs-dev xfstests-dev fio quota:
	./get-all

gce-xfstests.sh: kvm-xfstests/gce-xfstests.in
	sed -e "s;@DIR@;$$(pwd);" < $< > $@
	chmod +x $@

kvm-xfstests.sh: kvm-xfstests/kvm-xfstests.in
	sed -e "s;@DIR@;$$(pwd);" < $< > $@
	chmod +x $@

clean:
	./clean-all

kvm-xfstests/util/zerofree: kvm-xfstests/util/zerofree.c
	cc -static -o $@ $< -lext2fs -lcom_err -lpthread

realclean: clean
	rm -rf xfsprogs-dev xfstests-dev fio quota *.ver

tarball:
	./gen-tarball
