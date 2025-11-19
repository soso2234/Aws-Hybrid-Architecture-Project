const e = require('express');
const { request } = require('express');
const express = require('express');
const app = express();
const session = require('express-session');

//node restart 없이 자동반영되게끔
const fs = require('fs');   //filesystem으로 directory에 접근할수있게한다

app.use(session({
    secret: 'secret code',      //session에 대한 key
    resave: false,              //request 요청이 왔을 때 session에 수정 사항이 생기지 않더라도 session을 다시 저장할지 여부
    saveUninitialized: false,   //session에 저장 할 내역이 없더라도 session을 항상 재저장할지 여부
    cookie: {
        secure: false,          //false로 해야 session에 값이 넘어가고 뭐 이렇게 되나봄
        maxAge: 1000 * 60 * 60  //쿠키 유효시간 1시간
    }
}));

//데이터 받는거
app.use(express.json({
    limit: '50mb'
}));

const server = app.listen(3000, () => {
    console.log('Server started. port 3000.');
});

let sql = require('./sql.js');

fs.watchFile(__dirname + '/sql.js', (curr, prev) => {
    console.log('sql 변경 시 재시작 없이 반영되도록 함');
    delete require.cache[require.resolve('./sql.js')];          //캐시를날림
    sql = require('./sql.js');                                  //변경한 쿼리를 다시 담아줌 
});

//db 접속정보
const db = {
    database: "dev",
    connectionLimit: 10,
    host: "127.0.0.1",
    user: "root",
    password: "mariadb"
};

const dbPool = require('mysql').createPool(db);

app.post('/api/login', async (request, res) => {
    // request.session['email'] = '4off4@naver.com';
    // res.send('OK');
    try {
        await req.db('signUp', request.body.param);
        if(request.body.param.length > 0) {
            for(let key in request.body.param[0]) request.session[key] = request.body.param[0][key];
            res.send(request.body.param[0])
        }else{
            res.send({error:"Please Try Again or contact system Manager!"});
        }
    }catch(err) {
        res.send({
            error: "DB Access Error"
        });
    }
});

app.post('/api/logout', async (request, res) => {
    request.session.destroy();
    res.send('Ok');
});

/* 이미지업로드 */
app.post('/upload/:productId/:type/:fileName/:imageMaxId', async (request, res) => {
    let {
        productId,
        type,
        fileName,
        imageMaxId
    } = request.params;
    const dir = `${__dirname}/uploads/${productId}`;
    const file = `${dir}/${fileName}`;
    if (!request.body.data) return fs.unlink(file, async (err) => res.send({
      err
    }));
    const data = request.body.data.slice(request.body.data.indexOf(';base64,') + 8);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir);
    fs.writeFile(file, data, 'base64', async (error) => {
        console.log("이미지 업로드 중");
        console.log("imageMaxId : " + imageMaxId);
        await req.db('productImageInsert', [{
            id: imageMaxId,
            product_id: productId,
            type: type,
            path: fileName
        }]);
  
        if (error) {
            res.send({
            error
            });
        } else {
            res.send("ok");
        }
    });
  });
  
  app.get('/download/:productId/:fileName/:imageMaxId', (request, res) => {
    const {
      productId,
      type,
      fileName
    } = request.params;
    const filepath = `${__dirname}/uploads/${productId}/${fileName}`;
    res.header('Content-Type', `image/${fileName.substring(fileName.lastIndexOf("."))}`);
    if (!fs.existsSync(filepath)) res.send(404, {
      error: 'Can not found file.'
    });
    else fs.createReadStream(filepath).pipe(res);
  });

//:alias 위에 post로 login, logout 지정해놓은 것이 아닌 다른 key로 들어올 때 다 이걸 타는것이다
app.post('/apirole/:alias', async (request, res) => {
    if(!request.session.email) {
        return res.status(401).send({
            error:'You need to Login.'
        });
    }

    try {
        res.send(await req.db(request.params.alias));
    } catch(err) {
        res.status(500).send({
            error: err
        });
    }
});

//:alias DB 연결부
app.post('/api/:alias', async (request, res) => {
    try {
        res.send(await req.db(request.params.alias, request.body.param));
    } catch(err) {
        res.status(500).send({
            error: err
        });
    }
});

const req = { 
    async db(alias, param = [], where = '' ) {
        return new Promise((resolve, reject) => dbPool.query(sql[alias].query + where , param, (error, rows) => {
             if ( error ) {
                if ( error.code != 'ER_DUP_ENTRY')
                    console.log(error); 
                resolve({
                    error
                });
             } else resolve(rows);
        }));
     } 
};