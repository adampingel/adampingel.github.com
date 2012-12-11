#!/bin/bash

set -x
set -e

export SCALAVERSION="2.9.1"
export GROUP="org.pingel"
export ARTIFACT="axle_${SCALAVERSION}"
export VERSION="1.0"

function prep_repo {

    export LOCALIVY=~/.ivy2/local/$GROUP/$ARTIFACT/$VERSION

    # Note the / vs . difference in org/pingel:
    export MVNDIR=repo/org/pingel/${ARTIFACT}/${VERSION}
    mkdir -p $MVNDIR

    cp $LOCALIVY/poms/${ARTIFACT}.pom $MVNDIR/${ARTIFACT}-${VERSION}.pom
    cp $LOCALIVY/poms/${ARTIFACT}.pom.md5 $MVNDIR/${ARTIFACT}-${VERSION}.pom.md5
    cp $LOCALIVY/poms/${ARTIFACT}.pom.sha1 $MVNDIR/${ARTIFACT}-${VERSION}.pom.sha1
    cp $LOCALIVY/jars/${ARTIFACT}.jar $MVNDIR/${ARTIFACT}-${VERSION}.jar

    git add repo
}

function prep_scaladoc {
    rm -rf scaladoc
    mkdir -p scaladoc/
    (
	set -e
	cd scaladoc
	cp ~/.ivy2/local/$GROUP/$ARTIFACT/$VERSION/docs/${ARTIFACT}-javadoc.jar .
	jar xvf "${ARTIFACT}-javadoc.jar"
	rm "${ARTIFACT}-javadoc.jar"
    )
    git add scaladoc
}

prep_repo
prep_scaladoc
DATE=`date`
git commit -m "build on ${DATE}"
