#!/bin/bash

pc_data=$(hostnamectl)
operating_system=$(echo "$pc_data" | grep "Operating System:" | awk -F: '{print $2}' | tr -d '[:space:]')

printf "Yasin Şimşek   Linux - $operating_system"

