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
echo
echo


echo "Enter input file name (including extension)"
read -p "=> " base
echo
echo
echo "*Confirm that \"${base}\" is located in '$(pwd)' before continuing"
sleep 4
echo
echo "(Press 'Enter' to continue)"
read -p "" null
echo
type="${base##*.}"

echo "How many images would you like? (Higher is smoother, but 150-200 is recommended)"
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
echo
echo "Press 'Enter' to quit"
read -p "" quit
exit
