## Install nginx with rmtp module on using this
```
sudo apt update
sudo apt install build-essential git -y
sudo apt install libpcre3-dev libssl-dev zlib1g-dev -y

mkdir nginx-with-rmtp-module 
cd ~/nginx-with-rmtp-module
git clone https://github.com/arut/nginx-rtmp-module.git
git clone https://github.com/nginx/nginx.git
cd nginx
./auto/configure --add-module=../nginx-rtmp-module
make
sudo make install
```

## Backup the nginx.conf file using
`sudo mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.backup`

## Edit the nginx config file and paste these

`sudo nano /usr/local/nginx/conf/nginx.conf`

```
worker_processes  1;

events {
    worker_connections  1024;
}


rtmp { 
    server { 
        listen 1935; 
        application live { 
            live on; 
            interleave on;
 
            hls on; 
            hls_path /tmp/hls; 
            hls_fragment 15s; 

            dash on; 
            dash_path /tmp/dash; 
            dash_fragment 15s; 
        } 
    }
}

http {
    default_type application/octet-stream;
 
    server {
        listen 80; 
        location / {
            root /tmp; 
        }

        types {
            application/vnd.apple.mpegurl m3u8;
            video/mp2t ts;
            text/html html;
            application/dash+xml mpd;
        }
    }
}
```

## Check that the nginx config file is ok using
`sudo /usr/local/nginx/sbin/nginx -t`

## Start the nginx using
`sudo /usr/local/nginx/sbin/nginx`

## We can verify that the nginx is running using
`ps aux | grep -i nginx`

## Install the ffmpeg using
`sudo apt install ffmpeg -y`

## validate installation using
`ffmpeg -version`

## Download the video file 
`wget https://res.cloudinary.com/asthait/video/upload/v1607149818/services.mp4 -O video.mp4`

## Run the live using ffmpeg
`ffmpeg -re -i video.mp4 -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 -f flv rtmp://<your_ip_address>/live/stream-name`

## Connect to the stream via any network streaming software, we use VLC media player.
`https://www.videolan.org/vlc/`
## Paste your url in `Media > Open Network Stream` or `ctrl + n` shortcut

<br><br>

#### To increase the file size of any video use this. It loops the video 2 times and output the file in the output.mp4 file.
`ffmpeg -stream_loop -2 -i video.mp4 -c copy output.mp4`

<br><br>

## Reference
https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/

https://github.com/outcast/live-streaming-demo