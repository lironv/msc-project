
storageaccount1pw="<<DUMMYVALUE>>"
storageaccount2pw="<<DUMMYVALUE>>"
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
    sudo bash -c "echo \"//${1}projectmsc.file.core.windows.net/${1}fs-share ${3} cifs nofail,credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30\" >> /etc/fstab"
    sudo mount -t cifs //${1}projectmsc.file.core.windows.net/${1}fs-share ${3} -o credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30
}

mountfilesharestorageaccount $storageaccount1name $storageaccount1pw $mntdir01
mountfilesharestorageaccount $storageaccount2name $storageaccount2pw $mntdir02

# create and pass files to sa
mkdir $source_dir
cd $source_dir

for ((i=1; i<=100; i++)); do
    sudo touch "blob$i.txt"
done

function movefilestosharestorageaccount() {
# arguments: source directory, target directory
    for file in "$1"/*; do
        if [ -f "$file" ]; then
           filename=$(basename "$file")      
           sudo mv "$file" "$2/$filename"
        fi
    done
}
movefilestosharestorageaccount $source_dir $mntdir01
movefilestosharestorageaccount $mntdir01 $mntdir02

