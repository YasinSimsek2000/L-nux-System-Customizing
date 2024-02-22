#!/bin/bash

current_day=$(date +%d)
current_month=$(date +%m)
current_year=$(date +%Y)
current_date=$(date +"%d.%m.%Y")
prayer_times=$(curl -s "http://api.aladhan.com/v1/calendarByCity/$current_year/$current_month?city=Ankara&country=Turkey&method=13")

fajr=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Fajr" | sed 's/......$//')
sunrise=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Sunrise" | sed 's/......$//')
dhuhr=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Dhuhr" | sed 's/......$//')
asr=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Asr" | sed 's/......$//')
maghrib=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Maghrib" | sed 's/......$//')
isha=$(echo $prayer_times | jq -r ".data[] | select(.date.readable | contains(\"$current_day \")) | .timings.Isha" | sed 's/......$//')

echo "PRAYER    TIME"
echo "--------------"
echo "Fajr     $fajr"
echo "Sunrise  $sunrise"
echo "Dhuhr    $dhuhr"
echo "Asr      $asr"
echo "Maghrib  $maghrib"
echo "Isha     $isha"
