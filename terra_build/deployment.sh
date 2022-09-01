#!/usr/bin/env bash
set -u
ami=$(whoami)
maven_arch="$1"
maven_src="/tmp/${maven_arch}"
maven_dir="/opt/maven"
3fs_passwd_tmp="/tmp/.passwd-s3fs"
3fs_passwd_root="/root/.passwd-s3fs"
[ "${ami}" == "root" ] || (echo "You must be root!" && exit 1)
[ -e "${3fs_passwd_tmp}" ] || (echo "Sec password file is absent" && exit 1)
mv "${3fs_passwd_tmp}" "${3fs_passwd_root}"
chmod 400 "${3fs_passwd_root}"
apt-get update
apt-get install -y default-jdk git tar s3fs
rm -rf /var/lib/apt/lists/*
[ -e "${maven_src}" ] || (echo "Maven srcfolder ${maven_src}  is absent!" && exit 1)
([ -d "${maven_dir}" ] || mkdir ${maven_dir} 2> /dev/null) || (echo "Maven workfolder ${maven_src}  is absent!" && exit 1)
tar xpvf "${maven_src}" -C "${maven_dir}" --strip-components=1 > /dev/null 2>&1
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
ln -s ${maven_dir}/bin/mvn /bin/mvn