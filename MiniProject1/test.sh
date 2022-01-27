#!bin/bash
#1.Check if all folders were be created.
  if [ -d "./compressed_files/zip" ];then
          #Exist directory
          echo "Directory ./compressed_files/zip exist "
  else
          #Not exist directory
          mkdir ./compressed_files/zip
  fi
  if [ -d "./compressed_files/rar" ];then
          echo "Directory ./compressed_files/rar exist "
  else
          mkdir ./compressed_files/rar
  fi
  if [ -d "./compressed_files/tar.gz" ];then
          echo "Directory ./compressed_files/tar.gz exist "
  else
          mkdir ./compressed_files/tar.gz
  fi
  if [ -d "./compressed_files/unknown" ];then
          echo "Directory ./compressed_files/unknown exist "
  else
          mkdir ./compressed_files/unknown
  fi
while read line;
do
	file=$(find ./compressed_files/ -maxdepth 1 -name "$line*")
	echo "$file"
	if [ -f "$file" ];
	then
		filename=$(basename "$file")
		fname=${filename%%.*}
		#echo "$fname"
                ext=${filename#*.}
		#echo "$ext"
                if [ ! "$ext" == "tar.gz" ] && [ ! "$ext" == "rar" ] && [ ! "$ext" == "zip" ];
		then
			echo "$line" >> "./wrong_list"
			mv "compressed_files/$filename" ./compressed_files/unknown/
		fi
	else
		echo "$line" >> "./missing_list"
	fi
done < student_id
mv ./compressed_files/*.tar.gz ./compressed_files/tar.gz/
mv ./compressed_files/*.rar ./compressed_files/rar/
mv ./compressed_files/*.zip ./compressed_files/zip/

cd ./compressed_files/rar/
for rarf in *.rar;
do
	unrar e "$rarf";
done

cd ~/Linux_Week5_Lab/
cd ./compressed_files/zip/
unzip '*.zip'

cd ~/Linux_Week5_Lab/
cd ./compressed_files/tar.gz/
for tarf in *.tar.gz;
do
	tar xvzf "$tarf";
done

cd ~/Linux_Week5_Lab/
cd ..
zip -r Linux_Week5_Lab.zip Linux_Week5_Lab

exec bash

