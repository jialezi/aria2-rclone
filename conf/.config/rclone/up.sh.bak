#!/bin/sh
path=$3 #取原始路径，我的环境下如果是单文件则为/data/demo.png,如果是文件夹则该值为文件夹内某个文件比如/data/a/b/c/d.jpg
downloadpath='/home/aria2'  #Aria2下载文件目录
name='25t'  #配置Rclone时的name
folder='share'  #网盘里的文件夹
MinSize='1k' #限制最低上传大小，默认1k，BT下载时可防止上传其他无用文件。会删除文件，谨慎设置。
MaxSize='1024G' #限制最高文件大小，默认15G，OneDrive上传限制。

if [ $2 -eq 0 ]
    then
    exit 0
fi
while true; do  #提取下载文件根路径，如把/data/a/b/c/d.jpg变成/data/a
filepath=$path
path=${path%/*}; 
if [ "$path" = "" ] #不在下载文件夹
    then
    exit 0
elif [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]  #如果下载的是单个文件
    then
    rclone move "$filepath" ${name}:${folder}/ 
    exit 0
elif [ "$path" = "$downloadpath" ]   #文件夹
    then
    while [[ "`ls -A "$filepath/"`" != "" ]]; do
    rclone move "$filepath"/ ${name}:${folder}/"${filepath##*/}"/ --delete-empty-src-dirs --min-size $MinSize --max-size $MaxSize
    rclone delete -v "$filepath" --max-size $MinSize #删除多余的文件
    done
    rm -rf "$filepath/"
    exit 0
fi
done
