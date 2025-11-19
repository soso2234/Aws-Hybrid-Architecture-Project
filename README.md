aws ssh에서 구동시 해야할 사항
1. ec2 인스턴스 접속 후 yum install -y git
2. curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash   (NVM 설치 스크립트)
3. source ~/.bashrc 소스 적용
4. nvm install --lts (node 설치)
5. npm install -g @vue/cli (로 vue cli 설치 시간 다소 소요)
6. git clone (주소) 명령으로 파일 다운
7. /products/clint 에서 npm install 
8. NODE_OPTIONS=--openssl-legacy-provider npm run build   (빌드)
9. /products/server에서 npm run serve

# Aws-Hybrid-Architecture-Project
AWS 배포를 이용하여 웹사이트 구현
=======

<p align="center">
<h3>안녕하세요.<br> Shop 입니다.</h3>
</p>

## Install
npm install express --save <br/>
npm bootstrap --save <br/>

## terminal
server $ node app.js <br/>
client $ npm run serve <br/>

## Project
로컬 DB에 연결 되어있습니다. <br/>
사용 하신다면, 본인의 DB 연결을 하시면 됩니다. <br/>
It is connected to my local DB. If you use it, you can connect to your own DB.


## Initial screen
![Shop](/main.png)
![Shop](/productList.png)
![Shop](/productSelect.png)
![Shop](/cart.png)
![Shop](/buy.png)

