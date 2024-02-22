#!/bin/bash

url="https://api.binance.com/api/v3/avgPrice?symbol="
file="/etc/conky/box.txt"
usdt_try=$(curl -s "$url"USDTTRY | jq -r '.price')

total_usd=0
total_try=0

printf "%-5s %-11s %-8s %-11s\n" "Coin" "Amount" "USD" "Price"
echo "-------------------------------------"

while IFS= read -r line || [[ -n $line ]]; do
    read -ra arr <<< "$line"
    coin="${arr[0]}"
    amount="${arr[1]}"
    amount=$(echo "$amount" | awk '{gsub(/[^0-9.]/, ""); printf $1}')
    response=$(curl -s "$url$coin"USDT)
    market_value=$(echo "$response" | jq -r '.price')
    usd_amount=$(echo "$response" | jq -r '.price' | awk -v amount="$amount" '{printf "%.2f", $1 * amount}')
    total_usd=$(awk -v total_usd="$total_usd" -v usd_amount="$usd_amount" 'BEGIN {printf "%.2f", total_usd + usd_amount}')
    try_amount=$(awk -v usd_amount="$usd_amount" -v usdt_try="$usdt_try" 'BEGIN {printf "%.2f", usd_amount * usdt_try}')
    total_try=$(awk -v total_try="$total_try" -v try_amount="$try_amount" 'BEGIN {printf "%.2f", total_try + try_amount}')
    
    if (( $(echo "$market_value < 1" | bc -l) )); then
        printf "%-5s %-11s %-8s %-12s\n" "$coin" "$amount" "$usd_amount" "$(printf "%.8f" $market_value)"
    else
        printf "%-5s %-11s %-8s %-12s\n" "$coin" "$amount" "$usd_amount" "$(printf "%.2f" $market_value)"
    fi
done < "$file"

echo "-------------------------------------"
printf "%-5s %-12s" "Total " "" "$(printf "%.2f" $total_usd)  $(printf "%.2f" $total_try) ₺"
 
