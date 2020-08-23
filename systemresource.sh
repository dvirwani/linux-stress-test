#!/bin/bash
#=============================================================================
# Description: capture the system resource utilization and write in a csv file
#=============================================================================

# Main
# snapshot will be taken after every 5 seconds.
mpstat 5 > resourceutilization.csv