#!/bin/sh
set -x

VERSION=$(grep \<version\> YouTube/install.xml  | perl -n -e '/>(.*)</; print $1;')

zip -r YouTube-$VERSION.zip YouTube -x \*.zip \*.sh \*.git\* \*.t \*README\* \*webauth\*
SHA=$(shasum YouTube-$VERSION.zip | awk '{print $1;}')

cat <<EOF > public.xml
<extensions>
	<details>
		<title lang="EN">YouTube Plugin</title>
	</details>
	<plugins>
		<plugin name="YouTube" version="$VERSION" minTarget="7.5" maxTarget="*">
			<title lang="EN">YouTube</title>
			<desc lang="EN">Browse, search and play urls from soundcloud</desc>
			<url>http://danielvijge.github.io/YouTube/YouTube-$VERSION.zip</url>
			<link>https://github.com/danielvijge/YouTube</link>
			<sha>$SHA</sha>
			<creator>Triode, murkle, djbloc, Daniel Vijge, Daniel P. Berrange</creator>
		</plugin>
	</plugins>
</extensions>
EOF
