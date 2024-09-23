#!/bin/bash

# Define thresholds
CPU_THRESHOLD=10
MEMORY_THRESHOLD=10
DISK_THRESHOLD=10

# Get current CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

# Get top 5 running processes by CPU usage
TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)

# Check and display CPU usage alert
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "ALERT: CPU usage is at ${CPU_USAGE}%!"
fi

# Check and display memory usage alert
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "ALERT: Memory usage is at ${MEMORY_USAGE}%!"
fi

# Check and display disk space usage alert
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: Disk usage is at ${DISK_USAGE}%!"
fi

# Display top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
echo "$TOP_PROCESSES"

