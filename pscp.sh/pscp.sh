#!/bin/bash
###################################
#                                 #
# pscp.sh                         #
# v1.0                            #
# Copy files to multiple servers  #
# By albertorojassaez@gmail.com   #
#                                 #
###################################

#getInfo
usage(){
        cat << EOF
        usage: $0 options
        This script copy a file to path in many other servers.
        OPTIONS:
                -f      File to copy
                -t      Target path
                -s      Servers list textfile
                -u      Username
                -p      Pass
                -h      Help
EOF
}

#setValues
while getopts "hf:t:s:u:p:" OPTION; do
        case $OPTION in
         h)
             usage
             exit 1
             ;;
         f)
             file=$OPTARG
             ;;
         t)
             target=$OPTARG
             ;;
         s)
             servers=$OPTARG
             ;;
         u)
             username=$OPTARG
             ;;
         p)
             pass=$OPTARG
             ;;
        \?)
                echo "Invalid option: $OPTARG"
                ;;
        \:)
                echo "Invalid argument: $OPTARG"
                ;;
     esac
done

#validate
if [[ -z $file ]] || [[ -z $target ]] || [[ -z $servers ]] || [[ -z $username ]] || [[ -z $pass ]]
then
     usage
     exit 1
fi

#copy
while read R ; do
        sshpass -p $pass scp $file $username@$R:$target
        echo "Copied $file at $R:$target"
done < $servers
