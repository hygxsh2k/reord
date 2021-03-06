#!/bin/sh

# アルファベット順になるようにファイルを再配置する
[ -z "$(ls -AUCT0)" ] && exit 0
while [ "./$(ls -AU | tail -1)" != "$temp" ]
do
	temp=$(mktemp -p . XXXX)
	temps="$temps $temp"
done
tempdir=$(mktemp -d -p . tempdir.XXXX)
rm $temps
mv $(ls -AU | head -n-1) $tempdir
cd $tempdir
mv $(ls -A) ..
cd ..
rmdir $tempdir
