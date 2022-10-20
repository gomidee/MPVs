#!/bin/bash

#List of youtube Channels
Vitor_Liberato=https://www.youtube.com/feeds/videos.xml?channel_id=UC9BUxkHwS4hIpb04DXgpvKw
Primo_Rico=https://www.youtube.com/feeds/videos.xml?channel_id=UCT4nDeU5pv1XIGySbSK-GgA
Perini=https://www.youtube.com/feeds/videos.xml?channel_id=UCCE-jo1GvBJqyj1b287h7jA
Os_Socios=https://www.youtube.com/feeds/videos.xml?channel_id=UCzJPdSTGj7KPZLjaOatWS4A
Primocast=https://www.youtube.com/feeds/videos.xml?channel_id=UCfMA8s_QXPPcuOTjTDFb4vA
Huberman_Lab=https://www.youtube.com/feeds/videos.xml?channel_id=UC2D2CMWXMOVWx7giW1n3LIg
Jon_Olsson=https://www.youtube.com/feeds/videos.xml?channel_id=UCyQb1TTrfRzQZmEfsx770qw

video=$(cat f.tmp)

setup() {
  #Make sure files don't exist to avoid errors

touch f.tmp
sleep 1
rm *.tmp
sleep 1
touch f.tmp
}

fetch_videos() {
#Get RSS, make file with the video Title tmp
curl --silent $url | grep -E '(<title|link)' | sed -n '4,$p' | head -10 | sed -e s/"<\/title>"//g | sed -e s/"<title>"//g > vid.tmp; sed -n '1,1p;3,3p;5,5p;7,7p;9,9p' vid.tmp > title.tmp

#Get RSS, make file and create Link tmp
curl --silent $url | grep -E '(<title|link)' | sed -n '4,$p' | head -10 | sed -e s/"<\/title>"//g | sed -e s/"<title>"//g | sed -e s/"<link rel"//g | sed -e s/"alternate"//g | sed -e s/"href"//g | sed -e 's/\"//g' | sed -e 's/\>//g' | sed -e s"/\>"//g | sed 's/^.....//' | sed -n '2,2p;4,4p;6,6p;8,8p;10,10p'> link.tmp
}

select_video () {
  #Selects and plays the video
echo "Which video would you like to watch?"
sleep 1
cat -s -n title.tmp
read input
if [ $input == '1' ]; then cat link.tmp | sed -n '1,1p' > f.tmp; mpv $video
elif [ $input == '2' ];then cat link.tmp | sed -n '2,2p' > f.tmp; mpv $video
elif [ $input == '3' ];then cat link.tmp | sed -n '3,3p' > f.tmp; mpv $video
elif [ $input == '4' ];then cat link.tmp | sed -n '4,4p' > f.tmp; mpv $video
elif [ $input == '5' ];then cat link.tmp | sed -n '5,5p' > f.tmp; mpv $video

fi
}

#Get the videos from the RSS of the selected Channel, create files to help with video selection

setup

echo -e "Which Channel would you like to watch?
1) Vitor Liberato
2) O Primo Rico
3) Voce Mais Rico
4) Os Socios
5) Primocast
6) Huberman Lab
7) Jon Olsson"
read input
if [ $input == 1 ]; then url=$Vitor_Liberato fetch_videos; select_video
elif [ $input == 2 ]; then url=$Primo_Rico fetch_videos; select_video
elif [ $input == 3 ]; then url=$Perini fetch_videos; select_video
elif [ $input == 4 ]; then url=$Os_Socios fetch_videos; select_video
elif [ $input == 5 ]; then url=$Primocast fetch_videos; select_video
elif [ $input == 6 ]; then url=$Huberman_Lab fetch_videos; select_video
elif [ $input == 7 ];then url=$Jon_Olsson fetch_videos; select_video
fi
