#!/bin/sh

# '.reord_SAVED'で指定したファイル順に先頭から配置後、
# 残りのファイルをアルファベット順に再配置する。
# '.reord_SAVED'には'ls -fl --fu'相当のデータを含めると
# データ保全に役立つ。
[ ! -w '.' ] && exit 1
[ ! -s '.reord_SAVED' ] && exit 2
[ -n "$(grep -x -F '.' .reord_SAVED)" ] && exit 3
[ -n "$(grep -x -F '..' .reord_SAVED)" ] && exit 3
[ -n "$(grep -x -F '.reord_SAVED' .reord_SAVED)" ] && exit 3
[ -z "$(ls -AUCT0)" ] && exit 0
while [ "./$(ls -AU | tail -1)" != "$temp" ]
do
	temp=$(mktemp -p . XXXX)
	temps="$temps $temp"
done
tempdir=$(mktemp -d -p . tempdir.XXXX)
rm $temps
[ -s '.reord_SAVED' ] && mv $(awk '{print $NF}' .reord_SAVED) $tempdir
mv .reord_SAVED $tempdir
[ -n "$(ls -AU | head -n-1)" ] && mv $(ls -AU | head -n-1) $tempdir
cd $tempdir
mv $(awk '{print $NF}' .reord_SAVED) ..
mv .reord_SAVED ..
mv $(ls -A) ..
cd ..
rmdir $tempdir
