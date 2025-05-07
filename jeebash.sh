#!/bin/bash
date +%s > /tmp/seconds
if [ $# -eq 1 ]	# Arguments received as a single string?
	then
	set -- $@	# Chop it up
fi
args=("$@")	# Assign to array
if [[ "${args[0]}" == "0" ]];
	then
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/jeebash0.txt
	exit 1
else	
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/jeebash.txt
fi
TX="TX"
RX="RX"
ReInit="ReInit"
RFM69="RFM69x"
HASH0="0"
HASH1="1"
HASH0="2"
HASH1="3"
HASH0="4"
HASH1="5"

if [[ "${args[0]}" == "$RX" ]];
	then
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/rxArgs.txt
	/etc/heyu/rx.sh $@
	exit
elif [[ "${args[0]}" == "$TX" ]];
	then 
#	echo "$@" >> /etc/heyu/jeebash.txt
	/etc/heyu/tx.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]}
	exit
elif [[ "${args[0]}" == "$RFM69" ]];
	then
	echo  `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/rfm69.txt
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.txt
	exit
elif [[ "${args[0]}" == "SX1276" ]];
	then
	echo  `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/sx1276.txt
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.txt
	exit
elif [[ "${args[0]}" == "Sync" ]];
	then
	echo  `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Sync.txt
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.txt
	exit
elif [[ "${args[0]}" == "Reset" ]];
	then
	echo  `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Reset.txt
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.txt
	exit
elif [[ "${args[0]}" == "Eeprom" ]];
	then
	echo  `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Eeprom.txt
	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.txt
	exit
elif [[ "${args[0]}" == "$ReInit" ]];
	then 
	echo `date "+%d/%m/%Y %X"` "$@" >> /etc/heyu/jeebash.txt
	echo `date "+%d/%m/%Y %X"` "$@" >> /etc/heyu/RFxConsole.txt
	echo `date "+%d/%m/%Y %X"` "$@" >> /etc/heyu/reinit.txt
	exit
elif [[ "${args[0]}" == "OK" ]];
	then
	#
	#     OK 16 5 254 33 0 0 245 10 0 0
	# args 0  1 2   3  4 5 6   7  8 9 A
	#
	#The node number occupies 5 bits.

	#The A bit (ACK) 32 indicates whether this packet wants to get an ACK back. The C bit needs to be zero in this case (the name is somewhat confusing).

	#The D bit (DST) 64 indicates whether the node ID specifies the destination node or the source node. For packets sent to a specific node, DST = 1. For broadcasts, DST = 0, in which case the node ID refers to the originating node.

	#The C bit (CTL) 128 is used to send ACKs, and in turn must be combined with the A bit set to zero.

	# Get node number
	let node=${args[1]}
	# If ctl bit is set node will not match below - ignore ACK returns
	case $node in
	18) /etc/heyu/Jee18.sh $@ 
    #   Garden Shed Sensor          echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i18.txt &
	;;
	50) /etc/heyu/Jee18.sh $@
    #   Garden Shed Sensor          echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i18.txt &
	;;
	19) /etc/heyu/Jee19.sh 			$@ &
    #  Living Room Sensor           echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i19.txt &
	;;
	51) /etc/heyu/Jee19.sh 			$@ &
    #  Living Room Sensor           echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i19.txt &
	;;
	20) /etc/heyu/Jee20.sh 			$@ &
    #  Upstairs landing         echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i20.txt &
	;;
	52) /etc/heyu/Jee20.sh 			$@ &
    #  Upstairs Landing       echo "After" > /tmp/After
									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/i20.txt &
	;;
	21)  /etc/heyu/JeeRoomNodeDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                    ${args[10]} ${args[11]} ${args[12]} ${args[13]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeRoomNodeDecoder.txt                                    
	;;
	53)  /etc/heyu/JeeRoomNodeDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                    ${args[10]} ${args[11]} ${args[12]} ${args[13]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeRoomNodeDecoder.txt                                    
	;;
	4)  /etc/heyu/Jee04.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee04.txt                                    
	;;
	36) /etc/heyu/Jee04.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee04.txt
	;;
	5)  /etc/heyu/Jee05.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee05.txt                                    
	;;
	37) /etc/heyu/Jee05.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee05.txt
	;;
	6)  /etc/heyu/Jee06.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee06.txt                                    
	;;
	38) /etc/heyu/Jee06.sh  ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} ${args[9]} \
                                 ${args[10]} ${args[11]} ${args[12]} ${args[13]} ${args[14]} ${args[15]} ${args[16]} ${args[17]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/Jee06.txt
	;;
	131) 
	;;
	70)  /etc/heyu/JeePowerSneakDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeePowerSneakDecoder.txt                                    
	;;
	8)  /etc/heyu/JeePowerSneakDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} &
                                   echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeePowerSneakDecoder.txt                                    
	;;
	15) /etc/heyu/JeeGasCounterDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} &
                                    echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeGasCounterDecoder.txt
#								/etc/heyu/Outside.sh ${args[7]} &                                   
									/etc/heyu/JeeCentralUpdate.sh ${args[7]} &                                  
	;;
	47) /etc/heyu/JeeGasCounterDecoder.sh ${args[1]} ${args[2]} ${args[3]} ${args[4]} ${args[5]} ${args[6]} ${args[7]} ${args[8]} &
                                	echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeGasCounterDecoder.txt
#									/etc/heyu/Outside.sh ${args[7]} &                                   
									/etc/heyu/JeeCentralUpdate.sh ${args[7]} &                               
	;;
	49)  /etc/heyu/JeeCentralMonitor.sh $@ &
	                                   echo `date "+%d/%m/%Y %X"` ${args[26]} ${args[27]} ${args[28]} ${args[29]} ${args[30]} ${args[31]} ${args[32]} ${args[33]} &
                 					   >> /etc/heyu/JeeCentralTest.txt
	;;
	 1) /etc/heyu/JeeSHT11.sh $@ &
	 									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeSHT11.txt &
	;;
	33) /etc/heyu/JeeSHT11.sh $@ &
	 									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/JeeSHT11.txt &
    ;;
	 2) /etc/heyu/JeePudDecoder.sh $@ &
	 									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/puddingNode.txt &
	;;
	34) /etc/heyu/JeePudDecoder.sh $@ &
	 									echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/puddingNode.txt &
    ;;
	*)  echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/jeebash.err
	echo `date "+%d/%m/%Y %X"` Unknown $@ >> /etc/heyu/RFxConsole.txt
	;;
	esac
	else
		echo `date "+%d/%m/%Y %X"` $@ >> /etc/heyu/RFxConsole.err
	fi
