#!/bin/bash

#	signal TRAP
trap "echo -e \"EXITting\"" EXIT
trap "echo -e \"caught sigHUP\" ; exit" HUP
trap "echo -e \"caught sigINT\" ; exit" INT
trap "echo -e \"caught sigTERM\" ; exit" TERM

DRUN="docker run --volume $(pwd):/repo marchefter/silabs-firmware-builder"

for MANIFEST in $(find manifests/ -name '*.yaml') ; do
    MANIFEST_DIR=${MANIFEST%/*}
    FIRMWARE_DIR=${MANIFEST_DIR/manifests/firmware_built}

    [ -d ${FIRMWARE_DIR} ] || mkdir --parent ${FIRMWARE_DIR}
    ${DRUN} --manifest ${MANIFEST} --output gbl --output-dir ${FIRMWARE_DIR}
done
