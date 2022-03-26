## Download the video file 
`wget https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_1280_10MG.mp4`

## 
`wget https://download.blender.org/demo/movies/BBB/bbb_sunflower_1080p_60fps_normal.mp4`

## Rename the video file
`mv file_example_MP4_1280_10MG.mp4 video.mp4`

## run the live using ffmp3g
`ffmpeg -re -i video.mp4 -vcodec copy -loop -1 -c:a aac -b:a 160k -ar 44100 -strict -2 -f mp4 rtmp://15.207.112.136/live/bbb`

ffmpeg -re -i video.mp4 -vcodec copy -loop rtmp://15.207.112.136/live/bbb