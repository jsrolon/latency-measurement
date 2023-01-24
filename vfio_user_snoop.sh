#!/usr/bin/env bash

if [[ "${EUID}" -ne 0 ]]
  then echo "Please run as root"
  exit 1
fi

qemu_pid=$(pgrep qemu)
candidate_fd=$(lsof -a -U -p ${qemu_pid} | awk '!/libvirt/ {print $4}' | tail -n1 | tr -d u)
./vfio_user_snoop.bt ${qemu_pid} ${candidate_fd}
