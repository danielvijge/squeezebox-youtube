YouTube Plugin README
=====================

**NOTE: This version of the YouTube plugin doesn't work. It uses version 2 of the YouTube API, which YouTube depricated on
March 4, 2014, and disabled on April 20 2015.**

**A newer version is the YouTube plugin, with support for the YouTube API v3 has been created by philippe_44. The new plugin can be installed from the default 3rd party plugin list. There is no need to add a custom repository. The source code for the new version can be found at http://sourceforge.net/projects/lms-youtube/**

This repository contains source code for SqueezeBox YouTube plugin.

For more information, see http://forums.slimdevices.com/showthread.php?87731-Announce-YouTube-Plugin&highlight=youtube

Note: the creator of this repository is not the creator of the plugin. This repository is created post-hoc for the benefit of maintainers in the community only.

This YouTube plugin requires that the Perl installation used to run
the SlimServer have various 3rd party modules from CPAN installed:

    IO::Socket::SSL
    Mozilla::CA
    Net::SSLeay

If you are running a Linux distribution, these libraries are already installed, or can easily be installed by
your distribution's package manager. For example, on Debian based systems you can run

    # apt-get install libssl-dev
    # perl -MCPAN -e 'install IO::Socket::SSL'

This will install all the required modules.

If you are running SSODS on the QNap NAS, it requires some extra effort

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


After installing these packages, restart the SlimServer, at which point
the YouTube plugin should be functional.
