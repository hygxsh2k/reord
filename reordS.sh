#!/bin/sh -x

# '.reord_SAVED'で指定したファイル順に先頭から配置後、残りのファイルをアルファ
# ベット順に配置する。'.reord_SAVED'を'ls -fl --fu'コマンドの出力形式で記述して
# ファイルを管理しておくとデータの保全に役立つ。

[ ! -w '.' ] && exit 1
[ ! -r '.reord_SAVED' ] && exit 2
[ -z "$(ls -AUCT0)" ] && exit 0
while [ "./$(ls -AU | tail -1)" != "$temp" ]
do
	temp=$(mktemp -p . XXXX)
	temps="$temps $temp"
done
tempdir=$(mktemp -d -p . tempdir.XXXX)
rm $temps
saved=$(awk '{print $NF}' .reord_SAVED | grep -Fxv '.' | grep -Fxv '..' | grep -Fxv '.reord_SAVED')
[ -n "$saved" ] && mv $saved $tempdir
mv .reord_SAVED $tempdir
[ -n "$(ls -AU | head -n-1)" ] && mv $(ls -AU | head -n-1) $tempdir
cd $tempdir
[ -n "$saved" ] && mv $saved ..
mv .reord_SAVED ..
[ -n "$(ls -A)" ] && mv $(ls -A) ..
cd ..
rmdir $tempdir
