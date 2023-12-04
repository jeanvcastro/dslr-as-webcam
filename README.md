# Using DSLR camera as Webcam on Ubuntu

This guide explains how to use a DSLR camera as a webcam on Ubuntu.

## Supported Devices

Check if your device is supported by `gphoto2` [here](http://www.gphoto.org/proj/libgphoto2/support.php).

## Steps

### 1. Install Dependencies
Install the necessary packages by running:

```bash
sudo apt install gphoto2 v4l2loopback-dkms v4l2loopback-utils ffmpeg
```
### 2. Disable Secure Boot

Disable Secure Boot in your BIOS settings. This step is necessary to load the `v4l2loopback` kernel module.

### 3. Load v4l2loopback Module

Load the `v4l2loopback` module into the kernel with specific parameters. The `exclusive_caps=1` parameter is required for the camera to be recognized in Google Chrome. The `card_label` parameter provides a name for the virtual device.

```bash
sudo modprobe v4l2loopback exclusive_caps=1 card_label="Camera Loopback"
```

### 4. Start gphoto2

In my case, I set the resolution to HD and the fps to 30. The device I use is `/dev/video2`. Use `v4l2-ctl --list-devices` to find your device.

```bash
gphoto2 --stdout --set-config liveviewsize=0 --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 -s:v 1366x768 -r 30 /dev/video2
```

### Final Step: Script and Desktop Shortcut

Consider creating a script and a desktop shortcut for ease of use, similar to the one in this repository for the T6.

----------

Made with ❤️ by [jeanvcastro](https://github.com/jeanvcastro)
