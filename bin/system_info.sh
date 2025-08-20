#!/bin/bash

# A script to display system information

echo "--- System Information ---"

echo "Hostname: $(hostname)"
echo "Uptime: $(uptime)"
echo "Memory: $(free -h | grep Mem | awk '{print $3"/"$2}')"
echo "Disk: $(df -h / | awk 'NR==2 {print $3"/"$2}')"
