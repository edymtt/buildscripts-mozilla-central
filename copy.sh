rm -fr ~/Applications/Nightly.app

for IMAGE in obj-firefox/dist/*.dmg
do
	echo $IMAGE

	MOUNTPOINT=""
	DEVPATH=""
    hdiutil attach "$IMAGE" | {
    	while read REPLY; do
        echo $REPLY
        echo `echo $REPLY | sed "/expected/d" | wc -l`
        if [[ `echo $REPLY | sed "/expected/d" | wc -l | sed 's/^ *//g'` != 0 ]]
            then
         if [[ $DEVPATH == "" ]]
         	then
         	DEVPATH=`echo $REPLY | awk '{print $1}'`
         fi
         if [[ $MOUNTPOINT == "" ]]
         	then
         	MOUNTPOINT=`echo $REPLY | awk '{print $3}'`
         fi

         if [[ $MOUNTPOINT != "" && $DEVPATH != "" ]]
         	then
         	break
         fi
        fi
    done;


    if [[ $MOUNTPOINT == "" || $DEVPATH == "" ]]
    	then
    	echo "Error in finding where hdiutil mounted the IMAGE, MOUNTPOINT = $MOUNTPOINT, DEVPATH =$DEVPATH"
    	exit 1
    fi
	
	if [ -e $MOUNTPOINT ]
		then
	  cp -av $MOUNTPOINT/Nightly.app ~/Applications/

	  hdiutil detach $DEVPATH
	fi
}
done

#cp -av obj-firefox/dist/Nightly.app ~/Applications/
