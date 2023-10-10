
storageaccount1pw="mA+KROWAhR3+bSv9n/7pj94vpex1sviup5jo4QxEvP40yVumigyuR5Y4cztASBpXQfJXVQSb7iAL+AStd+PnQg=="
storageaccount2pw="VK0mSDvPPvxXKo8ErhsJ61Jy/C3txAB4cCkPM2mho4rwLQxgabaPBmiTafKGB+m39sVHFnOzWWck+AStfuUUnA=="
mntdir01="/mnt/${1}fs-share"
mntdir02="/mnt/${2}fs-share"
source_dir="/mnt/blobs"

function mountfilesharestorageaccount() {
    #arguments: storageaccount name, storageaccount password, mount directory, 
    sudo mkdir $3
    if [ ! -d "/etc/smbcredentials" ]; then
        sudo mkdir /etc/smbcredentials
    fi
    if [ ! -f "/etc/smbcredentials/${1}projectmsc.cred" ]; then
        sudo bash -c "echo \"username=${1}projectmsc\" >> /etc/smbcredentials/${1}projectmsc.cred"
        sudo bash -c "echo \"password=${2}\" >> /etc/smbcredentials/${1}projectmsc.cred"
    fi
    sudo chmod 600 /etc/smbcredentials/${1}projectmsc.cred
    sudo bash -c "echo \"//${1}projectmsc.file.core.windows.net/${1}fs-share ${3} cifs 
nofail,credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30\" 
>> /etc/fstab"
    sudo mount -t cifs //${1}projectmsc.file.core.windows.net/${1}fs-share ${3} -o 
credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30
}

mountfilesharestorageaccount $storageaccount1name $storageaccount1pw $mntdir01

