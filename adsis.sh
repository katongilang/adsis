#!/bin/bash

backup_fungsi (){

#KATON GILANG BAGASKARA
#71150009

#cuma memberi warning supaya pake root
  if [[ $EUID -ne 0 ]]; then #ngecek root ato bukan
    echo "==== Warning !! : Lokasi penyimpanan hasil backup akan terkena permission jika tidak menggunakan root =====" 1>&2
  fi

  echo -e "Masukkan file atau direktori yang ingin dibackup (menggunakan Full PATH !) : \c"
  read BACKUP_FILE #contoh "/home/katongilang/test/ayam.sh"

  #cek file atau direktori
  if [ -f $BACKUP_FILE ] || [ -d $BACKUP_FILE ]; then

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
    echo "Tidak ada ditemukan ! karena bukan nama file atau direktori !"
    sleep 2
    menu_fungsi
fi
}


restore_fungsi(){

#GRANLY H RUMONDOR
#71150024

  echo -e "Masukkan hasil Backup untuk di Restore ( menggunakan Full PATH ! ) : \c" #/home/katongilang/bakp.tar.gz
  read input1 # /home/granly/backup.13-Oct-17_13:27:49.tar.gz

  if [ -f $input1 ] || [ -d $input1 ]; then
    echo -e "Masukkan direktori tujuan untuk di restore (menggunakan Full PATH !) : \c"
    read input2 # /home/granly/coba

    if [ ! -d $input2 ]; then
      echo "Directory tidak ada !"
      sleep 1
      menu_fungsi
    fi

    COUNTER=0
    echo "Tunggu ... "
    while [ $COUNTER -lt 4 ]; do
      sleep 1
      echo "..."
      let COUNTER=COUNTER+1
    done

    mv $input1 $input2/hasil.tar.gz #dipindah dulu sekaligus ganti nama
    cd $input2 #masuk ke direktori tujuan restore
    tar xvzfP hasil.tar.gz #diextract
    rm hasil.tar.gz #diremove biar ga ketahuan

    echo "Restore COMPLETE !"
    date
    echo "======================"
    exit

  else
    echo "Bukan direktori dan bukan file !"
    sleep 2
    menu_fungsi
  fi

}


clear_cache_fungsi(){

#FELIX EVAN SANTOSO
#71150002

echo "Apakah anda ingin menampilkan info memory anda? (y/n)"
read text
case $text in
y ) cat /proc/meminfo
    echo "Apakah anda ingin membersihkannya? (y/n)"
      read input
      case $input in
      y )
	  if [[ $EUID -ne 0 ]]; then
		echo "Anda harus sebagai user root !" >&2
		exit 1
	  fi

	  # mendapatkan info memory
	  mem_sebelum=$(cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2) &&
	  mem_sebelum=$(echo "mem_sebelum/1024.0" | bc)
	  cached_sebelum=$(cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d ' ' -f2) &&
	  cached_sebelum=$(echo "$cached_sebelum/1024.0" | bc)

	  # informasi
	  echo -e "Script ini akan membersihkan cache memory merefresh ram anda.\n\nMemory Sebelum
	  $cached_sebelum MiB untuk cached dan $mem_sebelum MiB untuk RAM"

	  #Testing

	  #if [ $? -ne 0 ]; then
	#	  echo "Sistem menemukan adanya kesalahan"
	#	  exit 1
	 # fi

	  #membersihkan filesystem
	  sync && echo 3 > /proc/sys/vm/drop_caches

	  mem_sesudah=$(cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2) &&
	  mem_sesudah=$(echo "mem_sesudah/1024.0" | bc)

	  #informasi sekarang
	  echo -e "Memory sekarang  $(echo $mem_sesudah - $mem_sebelum | bc) MiB,
	  sekarang anda memliki
	  $mem_sesudah MiB free RAM"

	  exit
      ;;
      n )
      echo "Terimakasih"
      sleep 1
      menu_fungsi
      ;;
      * )
      echo "input error"
      sleep 1
      menu_fungsi
      ;;
      esac
  ;;
  n ) echo "Terimakasih"
      sleep 1
      menu_fungsi
  ;;
  * ) echo "Inputan error"
  ;;
esac

}



kalender_fungsi(){

#ARIF NOVIANTA BUSONO
#71150075

  clear
  echo "Kalender Tahun 2017"
  cal -y #memanggil kalender terbaru tahun ini
  echo -e "Mau lihat tahun berapa ?"
  read tahun
  echo -e "Mau lihat bulan apa (1-12)?"
  read bulan

  if [ $bulan -lt 1 ] || [ $bulan -gt 12 ]; then
    echo "masukkan bulan yang benar !"
    sleep 1
    menu_fungsi
  else
    cal $bulan $tahun #memanggil sesuai inputan user
  fi
  exit

}




trash_fungsi(){

#ANDREAS RILO KEVIN RITONGA
#71150028

 echo "======Isi Trash $USER saat ini=========="
 ls -1 /home/$USER/.local/share/Trash/files #menampilkan kebawah
 echo ""
 echo ""
  OPTIONS=("Menghapus file di trash" "Restore file di trash")
  select opt in "${OPTIONS[@]}"
    do
    case $opt in
    "Menghapus file di trash")
      echo -e "masukan file didalam trash yang ingin dihapus : \c"
      read NAMA_FILE

      #Lokasi default Trash pada Slackware /home/$USER/.local/share/Trash/files/
	  if [ -f /home/$USER/.local/share/Trash/files/$NAMA_FILE ] || [ -d /home/$USER/.local/share/Trash/files/$NAMA_FILE ]; then
	      if [ -f /home/$USER/.local/share/Trash/files/$NAMA_FILE ]; then #kalo file
		rm /home/$USER/.local/share/Trash/files/$NAMA_FILE #melakukan penghapusan
		echo "File $NAMA_FILE sudah dihapus !"
		sleep 2
		menu_fungsi
	      else #kalo direktori
		rmdir /home/$USER/.local/share/Trash/files/$NAMA_FILE #melakukan penghapusan
		echo "File $NAMA_FILE sudah dihapus !"
		sleep 2
		menu_fungsi
	      fi
	  else
	    echo "inputan tidak ada dalam trash !"
	    sleep 2
	    menu_fungsi
	  fi
      ;;

      "Restore file di trash")
      echo -e "Masukan file didalam trash yang ingin direstore : \c"
      read NM_FILE
	  if [ -f /home/$USER/.local/share/Trash/files/$NM_FILE ] || [ -d /home/$USER/.local/share/Trash/files/$NM_FILE ]; then
	      echo -e "Masukkan tujuan lokasi restore ( FULL PATH ! ): \c"
	      read LOKASI

	      if [ ! -d $LOKASI ]; then
		echo "Directory tidak ada !"
		sleep 2
		menu_fungsi
	      else
	      mv /home/$USER/.local/share/Trash/files/$NM_FILE  $LOKASI #proses restore / mindahin
	      echo " $NM_FILE berhasil direstore ke $LOKASI "
	      exit
	      fi
	  else
	    echo "inputan tidak ada dalam trash !"
	    sleep 2
	    menu_fungsi
	  fi
      ;;
	*) echo jangan ngaco kalo input !;;
      esac
     done
}


menu_fungsi(){
clear

echo "====================================================="
echo "=================== MENU SLACKWARE =================="
echo "====================================================="


OPTIONS=("Backup" "Restore" "Clear Cache" "Lihat Kalender" "Empty dan Restore Trash" "Keluar")
select opt in "${OPTIONS[@]}"
do
  case $opt in
    "Backup")
	backup_fungsi
	;;
    "Restore")
	restore_fungsi
	;;
    "Clear Cache")
        clear_cache_fungsi
	;;
    "Lihat Kalender")
	kalender_fungsi
	;;
    "Empty dan Restore Trash")
	trash_fungsi
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

