#!/bin/bash

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

if ! readelf -h "$file_name" >/dev/null 2>&1; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

magic_number=$(readelf -h "$file_name" | grep "Magic:" | xargs | cut -d' ' -f2-)
class=$(readelf -h "$file_name" | grep "Class:" | xargs | cut -d' ' -f2-)
byte_order=$(readelf -h "$file_name" | grep "Data:" | sed "s/.*2's complement, //")
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | xargs | cut -d' ' -f4)

source "$(dirname "$0")/messages.sh"

display_elf_header_info
