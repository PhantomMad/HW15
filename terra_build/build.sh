#!/usr/bin/env bash
set -u

git_url="$1"
git_dir="/tmp/git"
([ -d "${git_dir}" ] || mkdir ${git_dir} 2> /dev/null) || (echo "Git workfolder ${git_dir}  is absent!" && exit 1)
git clone "${git_url}" "${git_dir}"
cd "${git_dir}"
mvn clean package
cd ..
rm -rf "${git_dir}"