#!/bin/bash
conky -c /etc/conky/header.conf & 
conky -c /etc/conky/cpu_screen.conf & 
conky -c /etc/conky/system_monitor.conf & 
conky -c /etc/conky/ram_screen.conf & 
conky -c /etc/conky/prayer_times.conf & 
conky -c /etc/conky/coins.conf & 
conky -c /etc/conky/todo_list.conf & exit
