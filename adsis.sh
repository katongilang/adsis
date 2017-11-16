
#!/bin/bash

backup_fungsi (){



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



fi
}
