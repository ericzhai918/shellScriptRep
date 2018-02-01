#!/bin/bash

export LANG=en_US.UTF-8
SVN_AUTH_USER=xxxx
SVN_AUTH_PASS=xxxx
SVN_REMOTE_PATH="http://10.xx.xx.xx"
SVN="svn --username ${SVN_AUTH_USER} --password ${SVN_AUTH_PASS} --non-interactive --no-auth-cache"
PROJECT=$1
VERSION=$2
cd /tmp

${SVN} info ${SVN_REMOTE_PATH}/branches/${PROJECT}/${VERSION}
SVN_EXISTS_FOLDER=$?

if [ ${SVN_EXISTS_FOLDER} -eq 0 ]
then
    mkdir -p  ${PROJECT}
fi

cd ${PROJECT}

if [ ! -s ${VERSION} ]
then
        ${SVN} export ${SVN_REMOTE_PATH}//branches/${PROJECT}/${VERSION} &>/dev/null
        echo "The file you download in the folder: /tmp/${PROJECT}/${VERSION}"
fi
