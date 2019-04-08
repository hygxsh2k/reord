#!/bin/sh

# 引数のファイルで指定した順に先頭から配置後、
# 残りのファイルをアルファベット順に再配置する
[ -z "$1" ] && exit 1
[ -z "$(cat $1)" ] && exit 2
[ -z "$(ls -AUCT0)" ] && exit 0
while [ "./$(ls -AU | tail -1)" != "$temp" ]
do
	temp=$(mktemp -p . XXXX)
	temps="$temps $temp"
done
tempdir=$(mktemp -d -p . tempdir.XXXX)
rm $temps
mv $(cat $1) $tempdir
[ -n "$(ls -AU | head -n-1)" ] && mv $(ls -AU | head -n-1) $tempdir
cd $tempdir
mv $(cat $1) ..
mv $(ls -A) ..
cd ..
rmdir $tempdir
