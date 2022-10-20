#!/bin/sh

# url = https://www.youtube.com/feeds/videos.xml?channel_id=UC9BUxkHwS4hIpb04DXgpvKw
video=$(cat f.tmp)

touch f.tmp
sleep 1
rm *.tmp
sleep 1
touch f.tmp

#Get RSS, make file with the video Title tmp
curl --silent https://www.youtube.com/feeds/videos.xml?channel_id=UC9BUxkHwS4hIpb04DXgpvKw | grep -E '(<title|link)' | sed -n '4,$p' | head -10 | sed -e s/"<\/title>"//g | sed -e s/"<title>"//g > vid.tmp; sed -n '1,1p;3,3p;5,5p;7,7p;9,9p' vid.tmp > title.tmp
#Get RSS, make file and create Link tmp
curl --silent https://www.youtube.com/feeds/videos.xml?channel_id=UC9BUxkHwS4hIpb04DXgpvKw | grep -E '(<title|link)' | sed -n '4,$p' | head -10 | sed -e s/"<\/title>"//g | sed -e s/"<title>"//g | sed -e s/"<link rel"//g | sed -e s/"alternate"//g | sed -e s/"href"//g | sed -e 's/\"//g' | sed -e 's/\>//g' | sed -e s"/\>"//g | sed 's/^.....//' | sed -n '2,2p;4,4p;6,6p;8,8p;10,10p'> link.tmp

echo "Which video would you like to watch?"
sleep 1
cat -s -n title.tmp
read input
if [ $input == '1' ]; then cat link.tmp | sed -n '1,1p' > f.tmp; sleep 2; mpv $video
elif [ $input == '2' ];then cat link.tmp | sed -n '2,2p' > f.tmp; sleep 2; mpv $video
elif [ $input == '3' ];then cat link.tmp | sed -n '3,3p' > f.tmp; sleep 2; mpv $video
elif [ $input == '4' ];then cat link.tmp | sed -n '4,4p' > f.tmp; sleep 2; mpv $video
elif [ $input == '5' ];then cat link.tmp | sed -n '5,5p' > f.tmp; sleep 2; mpv $video

fi
