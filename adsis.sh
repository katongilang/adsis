#!/bin/bash

backup_fungsi (){

#cuma memberi warning supaya pake root
  if [[ $EUID -ne 0 ]]; then #ngecek root ato bukan
    echo "==Warning !! : Beberapa lokasi penyimpanan hasil backup akan terkena permission jika tidak menggunakan root" 1>&2
    echo ""
  fi

  echo -e "Masukkan direktori yang ingin dibackup (menggunakan Full PATH !) : \c" #yang dibackup direktori
  read BACKUP_FILE #contoh "/home/katongilang/test"

#cek direktori
  if [ -d $BACKUP_FILE ]; then

    echo -e "Masukkan lokasi penyimpanan (menggunakan Full PATH !) : \c"
    read TUJUAN #contoh lokasi tujuan /home/katongilang/test"

    #cek direktori tujuan penyimpanan ada gak
    if [ ! -d $TUJUAN ]; then
      echo "Directory tidak ada !"
      sleep 1
      menu_fungsi
    fi


    #proses loding ...
    COUNTER=0
    echo "Tunggu ... "
    while [ $COUNTER -lt 4 ]; do
      sleep 1
      echo "..."
      let COUNTER=COUNTER+1
    done

    #proses backup
    TIME=`date +%d-%b-%y_%H:%M:%S` #format naming supaya namanya beda beda setiap backup/ gak replace
    ARCHIVE_FILE="backup.$TIME.tar.gz" #nama file hasil backup
    echo "Backup $BACKUP_FILE to $TUJUAN/$ARCHIVE_FILE"
    tar czfP $TUJUAN/$ARCHIVE_FILE $BACKUP_FILE #untuk kompress dan menyimpan di suatu folder
    echo "BACKUP COMPLETE !"
    echo "Waktu Sekarang : `date` "
    echo "======================"
    exit
    
     else
    echo "Tidak ada ditemukan ! karena bukan nama direktori !"
    sleep 2
    menu_fungsi

fi
}
restore_fungsi(){
  echo -e "Masukkan hasil Backup untuk di Restore ( menggunakan Full PATH ! ) : \c" #/home/katongilang/bakp.tar.gz
  read input1 # /home/granly/backup.13-Oct-17_13:27:49.tar.gz

  if [ -f $input1 ]; then

	COUNTER=0
	echo "Tunggu ... "
	while [ $COUNTER -lt 4 ]; do
	 sleep 1
	 echo "..."
	 let COUNTER=COUNTER+1
	done
	
	tar xvzfP $input1 #diextract
	
	echo "Restore COMPLETE!"
	date
	echo "==========================="
	exit
	
   else
    echo "Tidak ditemukan !"
    sleep 2
    menu_fungsi
  fi
}

menu_fungsi(){
clear

echo "====================================================="
echo "=================== MENU SLACKWARE =================="
echo "====================================================="


OPTIONS=("Backup Folder" "Restore" "Keluar")
select opt in "${OPTIONS[@]}"
do
  case $opt in
    "Backup")
	backup_fungsi
	;;
    "Restore")
	restore_fungsi
	;;
    "Keluar")
	echo "GOODBYE !"
	sleep 2
	clear
	exit
	;;
	*) echo jangan ngaco kalo input !;;
  esac
 done
 }

 #main
 menu_fungsi #panggil fungsi menu
