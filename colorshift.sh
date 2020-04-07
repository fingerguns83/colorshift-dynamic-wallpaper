#!/bin/bash

clear;
echo '___________________________________________________________'
echo '                                                           |'
echo 'ColorShift - "Dynamic" Wallpaper Generator by fingerguns83 |'
echo 'https://github.com/fingerguns83                            |'
echo '___________________________________________________________|'
sleep 1
echo
echo "**Press control+c at any time to exit**"
sleep 2

cd "$(dirname "$0")"

base=$(ls | sed 's/.*.sh//g')
base=$(echo "${base//[$'\n']}")
baseValid=""

while [[ "$baseValid" != "y" ]]
do
  echo
  echo
  echo "${base} has been detected as the target image, is this correct? (y/n)"
  echo
  read -p "=> " baseValid

  if [[ "$baseValid" == "n" ]]
  then
    exit
  fi
done

type="${base##*.}"

echo
echo "How many images would you like?"
echo "(Higher is smoother, but 150-200 is recommended)"
echo
read -p "=> " count
if [[ "$count" == "" ]]
then
  echo "Deferred to default (200)"
  count=200
fi
echo

echo "Ready"
sleep 1
echo "Set"
sleep 1
echo "GO!"
sleep 0.5

#initialize vars
hueInc=$(echo "scale=4; 200 / $count" | bc)
hue=0
count=$(( $count + 1 ))

#start file generation
for ((i = 1 ; i < $count ; i++));
do
  outName=$i

#check file name
  while [[ "${#outName}" < "${#count}" ]]
  do
    outName="0${outName}"
  done
  outFile=${outName}.${type}

  convert $base -modulate 100,100,$hue $outFile

#progress
  complete=$(echo "scale=2; ((${i}*100)/(${count} - 1))" | bc)
  echo -ne " ${complete}% \r"

#increment hue
  hue=$(echo "scale=4; $hue + $hueInc" | bc)
done

echo
echo
echo "Complete!"
sleep 1


remove=""
while [[ "$remove" != "n" ]]
do
  echo
  echo
  echo "Remove original image? (y/n)"
  echo
  read -p "=> " remove

  if [[ "$remove" == "y" ]]
  then
    rm $base
    echo
    echo "Press 'Enter' to quit"
    read -p "" quit
    exit
  fi
done

echo
echo "Press 'Enter' to quit"
read -p "" quit
exit
