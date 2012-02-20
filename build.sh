#!/bin/bash +x

set -e

export SCALAVERSION="2.9.1"
export GROUP="org.pingel"
export ARTIFACT="axle_${SCALAVERSION}"
export VERSION="1.0"

mkdir -p repo/$GROUP/$ARTIFACT/
cp -R ~/.ivy2/local/$GROUP/$ARTIFACT/$VERSION repo/$GROUP/$ARTIFACT/
git add repo

mkdir -p scaladoc/
(
    set -e
    cd scaladoc
    cp ~/.ivy2/local/$GROUP/$ARTIFACT/$VERSION/docs/${ARTIFACT}-javadoc.jar .
    jar xvf "${ARTIFACT}-javadoc.jar"
    rm "${ARTIFACT}-javadoc.jar"
)
git add scaladoc

DATE=`date`

git commit -m "build on ${DATE}"
