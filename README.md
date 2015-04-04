YouTube Plugin README
=====================

This repository contains source code for SqueezeBox YouTube plugin.

For more information, see http://forums.slimdevices.com/showthread.php?87731-Announce-YouTube-Plugin&highlight=youtube

Note: the creator of this repository is not the creator of the plugin. This repository is created post-hoc for the benefit of maintainers in the community only.

This YouTube plugin requires that the Perl installation used to run
the SlimServer have various 3rd party modules from CPAN installed:

    Mozilla::CA
    Net::SSLeay
    IO::Socket::SSL
    JSON


If running on a normal Linux system these are usually already provided
by your distro, but when running SSODS on the QNap NAS, it requires
some extra effort

The folowing steps were tested on a QNap NAS running firmware 4.1.2

First you need OptWare enabled, so you can use ipkg to install the
build toolchain.

    # ipkg install openssl openssl-dev
    # ipkg install make
    # ipkg install gcc

Change into the slimserver installation directory

    # cd /opt/ssods4
    # mkdir tmp
    # cd tmp

    # wget http://search.cpan.org/CPAN/authors/id/A/AB/ABH/Mozilla-CA-20141217.tar.gz
    # tar zxvf Mozilla-CA-20141217.tar.gz
    # cd Mozilla-CA-20141217
    # ../../bin/perl Makefile.PL
    # make
    # make install
    # cd ..


    # wget http://search.cpan.org/CPAN/authors/id/M/MI/MIKEM/Net-SSLeay-1.68.tar.gz
    # tar zxvf Net-SSLeay-1.68.tar.gz
    # cd Net-SSLeay-1.68
    # OPENSSL_PREFIX=/opt ../../bin/perl Makefile.PL
    # make
    # make install
    # cd ..


    # wget http://search.cpan.org/CPAN/authors/id/S/SU/SULLR/IO-Socket-SSL-2.012.tar.gz
    # tar zxvf IO-Socket-SSL-2.012.tar.gz
    # cd IO-Socket-SSL-2.012
    # ../../bin/perl Makefile.PL
    # make
    # make install
    # cd ..


    # wget  http://search.cpan.org/CPAN/authors/id/M/MA/MAKAMAKA/JSON-2.90.tar.gz
    # tar zxvf JSON-2.90.tar.gz
    # cd JSON-2.90
    # ../../bin/perl Makefile.PL
    # make
    # make install
    # cd ..


After installing these packages, restart the SlimServer, at which point
the YouTube plugin should be functional.
