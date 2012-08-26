d=$(date +"%Y-%m-%d")
zip -r ${PWD##*/}.$d.love assets music *.lua *.txt
