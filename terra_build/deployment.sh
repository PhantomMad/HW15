#!/usr/bin/env bash
set -u
ami=$(whoami)
maven_arch="$1"
maven_src="/tmp/${maven_arch}"
maven_dir="/opt/maven"
3fs_passwd_tmp="/tmp/.passwd-s3fs"
3fs_passwd_root="/root/.passwd-s3fs"
mnt_folder="/tmp/mount"
[ "${ami}" == "root" ] || (echo "You must be root!" && exit 1)
[ -e "${3fs_passwd_tmp}" ] || (echo "Sec password file is absent in tmp" && exit 1)
mv /tmp/.passwd-s3fs /root/
[ -e "${3fs_passwd_root}" ] || (echo "Sec password file is absent in root" && exit 1)
chmod 400 /root/.passwd-s3fs
apt-get update
apt-get install -y default-jdk git tar s3fs > /dev/null 2>&1
rm -rf /var/lib/apt/lists/*
[ -e "${maven_src}" ] || (echo "Maven srcfolder ${maven_src}  is absent!" && exit 1)
([ -d "${maven_dir}" ] || mkdir ${maven_dir} 2> /dev/null) || (echo "Maven workfolder ${maven_src}  is absent!" && exit 1)
([ -d "${mnt_folder}" ] || mkdir ${mnt_folder} 2> /dev/null) || (echo "Mount workfolder ${mnt_folder}  is absent!" && exit 1)
s3fs hw15 /tmp/mount -o passwd_file=/root/.passwd-s3fs -o url=http://storage.yandexcloud.net -o use_path_request_style
tar xpvf "${maven_src}" -C "${maven_dir}" --strip-components=1 > /dev/null 2>&1
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
ln -s ${maven_dir}/bin/mvn /bin/mvn
