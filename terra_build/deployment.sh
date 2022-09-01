#!/usr/bin/env bash
set -u
ami=$(whoami)
maven_arch="apache-maven-3.8.6-bin.tar.gz"
maven_src="/tmp/${maven_arch}"
maven_dir="/opt/maven"
[ "${ami}" == "root" ] || exit 1
apt-get update > /dev/null 2>&1
apt-get install -y default-jdk git tar > /dev/null 2>&1 || exit 1
rm -rf /var/lib/apt/lists/*
[ -e "${maven_src}" ] || exit 1
([ ! -d "${maven_dir}" ] && mkdir ${maven_dir} 2> /dev/null) || exit 1
tar xpvf "${maven_src}" -C "${maven_dir}" --strip-components=1 > /dev/null 2>&1
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
ln -s ${maven_dir}/bin/mvn /bin/mvn


