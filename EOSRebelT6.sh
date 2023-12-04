#!/bin/bash

# Define a function for privileged operations
privileged_operations() {
    # Remove v4l2loopback module
    rmmod v4l2loopback

    # Load v4l2loopback module into the kernel
    modprobe v4l2loopback exclusive_caps=1 card_label="EOS Rebel T6"
}

# Unmount the camera (to find your camera's mount path, run: gio mount -l)
gio mount -u gphoto2://Canon_Inc._Canon_Digital_Camera/

# Execute the privileged operations with pkexec
pkexec bash -c "$(declare -f privileged_operations); privileged_operations"

# Start gphoto2
# My camera is recognized as /dev/video2
# To find out how your camera is recognized, after loading the v4l2loopback module, run: v4l2-ctl --list-devices
gphoto2 --stdout --set-config liveviewsize=0 --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0  -f v4l2 -s:v 1366x768 -r 25 /dev/video2

