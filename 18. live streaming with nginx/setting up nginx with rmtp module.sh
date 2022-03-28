# https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/
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

# nginx is in here /usr/local/nginx/conf