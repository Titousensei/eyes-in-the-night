d=$(date +"%Y-%m-%d")
rm -f ${PWD##*/}.$d.love 2> /dev/null
zip -r ${PWD##*/}.$d.love assets music *.lua *.txt
