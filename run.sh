#!/bin/sh

echo -e "AccountID ${ACCOUNT_ID}\nLicenseKey ${LICENSE_KEY}\nEditionIDs ${EDITION_IDS}"  >> /usr/local/etc/GeoIP.conf

/usr/local/bin/geoipupdate

./exporter