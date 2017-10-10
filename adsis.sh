#!/bin/bash
clear

echo "======================================="
echo "==============BACKUP MENU=============="
echo "======================================="

OPTIONS=("Backup" "Restore" "Destination" "Exit")
select opt in "${OPTIONS[@]}"
do
  case $opt in
     "Backup")
    
    echo -e "Masukan file yang ingin dibackup (menggunakan FULL PATH 
!) : \c"
    read BACKUP_FILE
    #cek file ada gak
    if [ ! -f $BACKUP_FILE ]; then
      echo "File tidak ada !"
      sleep 2
      exit
    fi

    echo -e "Masukan lokasi penyimpanan (menggunakan FULL PATH !) : 
\c"
    read DESTIN
    #cek direktori ada gak
    if [ ! -d $DESTIN ]; then
      echo "Direktori tidak ada !"
      sleep 2
      exit
    fi

    COUNTER=0
    echo "Tunggu ..."
    while [ $COUNTER -lt 6 ]; do
     sleep 1
     echo "..."
     let COUNTER=COUNTER+1
    done

    DAY=$(date +%Y-%m-%d)
    ARCHIVE_FILE="backup.$DAY.tar.gz" #nama file hasil backup
    echo "Backup %BACKUP_FILE to $DESTIN/$ARCHIVE_FILE"
    tar czfP $DESTIN/$ARCHIVE_FILE $BACKUP_FILE #untuk compress dan menyimpan disuatu folder
    echo "BACKUP COMPLETE !"
    date

    echo "======================="
    echo "Jalankan AutoBackup dengan cron (y/n) ? "
       OPTIONS=("Ya" "Tidak")
          select opt in "${OPTIONS[@]}"
          do
        case $opt in
          "Ya")
          #masih belum . .. susah
          ;;
          "Tidak")
          echo "Oke Terimakasih!"
          sleep 2
          clear
          exit
        ;;
        *) echo jangan ngaco kalo input!
        esac
         done
    ;;
     "Exit")
    echo "GOODBYE !"
    sleep 2
    clear
    break
    ;;
    *) echo jangan ngaco kalo input !;;
  esac
done
