
storageaccount1pw="<<DUMMYVALUEPASSWORD1>>"
storageaccount2pw="<<DUMMYVALUEPASSWORD2>>"
mntdir01="/mnt/${1}fs-share"
mntdir02="/mnt/${2}fs-share"
source_dir="/mnt/blobs"


# sudo mkdir $mntdir01
# if [ ! -d "/etc/smbcredentials" ]; then
# sudo mkdir /etc/smbcredentials
# fi
# if [ ! -f "/etc/smbcredentials/${1}projectmsc.cred" ]; then
#     sudo bash -c "echo \"username=${1}projectmsc\" >> /etc/smbcredentials/${1}projectmsc.cred"
#     sudo bash -c "echo \"password=${storageaccount1pw}\" >> /etc/smbcredentials/${1}projectmsc.cred"
# fi
# sudo chmod 600 /etc/smbcredentials/${1}projectmsc.cred

# sudo bash -c "echo \"//${1}projectmsc.file.core.windows.net/${1}fs-share ${mntdir01} cifs nofail,credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30\" >> /etc/fstab"
# sudo mount -t cifs //${1}projectmsc.file.core.windows.net/${1}fs-share ${mntdir01} -o credentials=/etc/smbcredentials/${1}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30


# sudo mkdir $mntdir02
# if [ ! -d "/etc/smbcredentials" ]; then
# sudo mkdir /etc/smbcredentials
# fi
# if [ ! -f "/etc/smbcredentials/${2}projectmsc.cred" ]; then
#     sudo bash -c "echo \"username=${2}projectmsc\" >> /etc/smbcredentials/${2}projectmsc.cred"
#     sudo bash -c "echo \"password=${storageaccount2pw}\" >> /etc/smbcredentials/${2}projectmsc.cred"
# fi
# sudo chmod 600 /etc/smbcredentials/${2}projectmsc.cred

# sudo bash -c "echo \"//${2}projectmsc.file.core.windows.net/${2}fs-share ${mntdir02} cifs nofail,credentials=/etc/smbcredentials/${2}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30\" >> /etc/fstab"
# sudo mount -t cifs //${2}projectmsc.file.core.windows.net/${2}fs-share ${mntdir02} -o credentials=/etc/smbcredentials/${2}projectmsc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30

# create and pass files to sa


#mkdir $source_dir
cd $source_dir
for i in {1..100}; do touch "filename$i"; done
cd ..
for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")  
        sudo mv "$file" "$mntdir01/$filename"
    fi
done

for file in "$mntdir01"/*; do
    if [ -f "$file" ]; then
       filename=$(basename "$file")      
       sudo mv "$file" "$mntdir02/$filename"
    fi
done



