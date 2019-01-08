#!/bin/bash

app_name="QQMusic"
app_extra_name="libsubstitute"
shell_path="$(dirname "$0")"
qq_path="/Applications/QQMusic.app"
framework_name="libQQMusicHelper"
app_bundle_path="/Applications/${app_name}.app/Contents/MacOS"
app_executable_path="${app_bundle_path}/QQMusic"
app_executable_backup_path="${app_executable_path}_backup"
framework_path="${app_bundle_path}/${framework_name}.dylib"

# 对 QQ 赋予权限
if [ ! -w "$qq_path" ]
then
echo -e "\n\n为了将小助手写入QQ音乐, 请输入密码 ： "
sudo chown -R $(whoami) "$qq_path"
fi

# 备份 QQ 原始可执行文件
if [ ! -f "$app_executable_backup_path" ]
then
cp "$app_executable_path" "$app_executable_backup_path"
result="y"
else
read -t 150 -p "已安装QQ音乐小助手，是否覆盖？[y/n]:" result
fi

if [[ "$result" == 'y' ]]; then
    cp -r "${shell_path}/Products/Debug/${framework_name}.dylib" ${app_bundle_path}
    cp -r "${shell_path}/Tools/${app_extra_name}.dylib" ${app_bundle_path}
    ${shell_path}/insert_dylib --all-yes "${framework_path}" "$app_executable_backup_path" "$app_executable_path"
fi
