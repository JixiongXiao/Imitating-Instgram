var express = require("express");
var bodyParser = require("body-parser");
var session = require("express-session");
var port = "8081";
var app = express();
var mysql = require("mysql");
var fileUpload = require("express-fileupload");

app.use(express.static("static"));
app.use(bodyParser.urlencoded({extended:true}));
app.use(fileUpload());
app.use(session({
    secret: 'jixiongXiao',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 600000 }
}));
app.set("view_engine", "ejs");
app.set("views", "templates");

//function
function currentTime (){
    var myDate = new Date();
    var h = myDate.getHours();
    h = h < 10 ? ("0"+ h):h;
    var m = myDate.getMinutes();
    m = m < 10 ? ("0"+m):m;
    var s = myDate.getSeconds();
    s = s < 10 ? ("0"+s):s;
    var time =h + ":" + m + ":" + s + "  " + myDate.toLocaleDateString().split('/').join('-');
    return time;
}

var conn = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"root",
    database:"final_project"
});

conn.connect(function(err){
    if(err){
        console.log("Error:"+err);
    }else{
        console.log("connect to database")
    }
});

app.get("/",function(req,res){
    conn.query(`SELECT * FROM images`,function(err,img){
        conn.query( `SELECT * FROM comments`,function(err,ctn){
            conn.query(`SELECT * FROM likes`,function(err,likes){
                res.render("homePage.ejs",{"imgDB":img,"ctnDB":ctn,"likes":likes});
            });
        })

    });
});
app.post("/signUp",function(req,res){
    var username = req.body.username;
    var password = req.body.password;
    var firstname = req.body.firstname;
    var surname = req.body.surname;
    var sql = `INSERT INTO users(user, password, firstname, surname) VALUE ("${username}","${password}","${firstname}","${surname}")`;
    console.log(sql);
   if(username && password && firstname && surname){
       conn.query(sql,function(err,result){
           if(err){
               res.send("Username has been used. Please Register again");
           } else {
               res.redirect("hintSignUp.html");
           }
       });
   } else{
       res.send("Please complete the form");
   }
});
//current user
var validUser;
var logIn = false ;
app.post("/login",function(req,res){
    var username = req.body.username;
    var password = req.body.password;
    if(username && password){
        conn.query(`SELECT surname FROM users WHERE user =? AND password = ?`,[username,password],function(err,result){
            if(result.length > 0 ){
                // conn.query(`SELECT * FROM images`,function(err,result){
                //     req.session.username = username;
                //     logIn = true ;
                //     res.render("profile.ejs",{"visitor":username,"imgDB":result});
                // });
                conn.query(`SELECT * FROM images`,function(err,img){
                    conn.query( `SELECT * FROM comments`,function(err,ctn){
                        conn.query(`SELECT * FROM likes`,function(err,likes){
                            req.session.username = username;
                            logIn = true ;
                            res.render("profile.ejs",{"visitor":username,"imgDB":img,"ctnDB":ctn,"likes":likes});
                        });
                    })

                });
            } else{
                res.send("Incorrect username or password!");
                giveThumbUp = false;
            }
        })
    } else {
        res.send("Please input username and password");
    }
});

app.get("/logout",function(req,res){
    req.session.destroy();
    logIn = false;
    giveThumbUp = false;
    res.redirect("/");
});

app.post("/upload",function(req,res){
    validUser = req.session.username;
    var file = req.files.myimage;
    currentTime();
    console.log(file);
    if(file.length !== 0) {
        file.mv("static/uploads/" + file.name);
        // add new data into table likes
        conn.query(`INSERT INTO likes (thumb,user,file) VALUE ("${0}","${validUser}","${file.name}")`,function(err,result){
            console.log("add thumbUp successfully");
        });
        //add new data into table images
        conn.query(`INSERT INTO images (file,date,user,thumb) VALUE ("${file.name}","${currentTime()}","${validUser}","${0}")`, function (err, result) {
            if (err) {
                res.send("Please try again");
            } else {
                conn.query(`SELECT * FROM images`,function(err,img){
                    conn.query( `SELECT * FROM comments`,function(err,ctn){
                        conn.query(`SELECT * FROM likes`,function(err,likes){
                            var username=req.session.username;
                            res.render("image.ejs",{"visitor":username,"imgDB":img,"ctnDB":ctn,"likes":likes});
                        });
                    })

                });
            }
        });
    } else{
        // console.log(file.length);
        res.send("Please try again");
    }
});

//current image
var validImg;
var like;
var giveThumbUp = false;
app.get("/image/:img",function(req,res){
    giveThumbUp = false;
    validImg = req.params.img;
    //show comment
    conn.query(`SELECT date,user,comment  FROM comments WHERE file= ?`,[validImg],function(err,result){
        //show thumbUp
        console.log("results: "+ [validImg]);
        conn.query(`SELECT thumb FROM likes WHERE file = ?`,[validImg],function(err,thumb){

            like = thumb[0]["thumb"];
            console.log("this is empty "+thumb);

            res.render("detail.ejs",{"fileName":validImg,"com":result,"thumb":like});
        });

    });
});
app.post("/comment",function(req,res){
    //check logIn is true or false;
    if(logIn){
    var comment = req.body.comment;
    validUser = req.session.username;
    currentTime();
    //add new comment into table comments
    conn.query(`INSERT INTO comments(file,date,user,comment) VALUE("${validImg}","${currentTime()}","${validUser}","${comment}")`,
        function(err,result){
            res.redirect("/image/"+validImg);
        });} else {
        res.redirect("hint.html");
    }
});
app.get("/thumbUp",function(req,res){
    console.log(giveThumbUp);
        //get the number of thumbUp
    if (giveThumbUp ===  false){
        like += 1;
        giveThumbUp = true;
        // $("#btn").css("background:url(\"../img/thumbUpA.png\") no-repeat");
        conn.query(`UPDATE likes SET thumb = ? WHERE file = ?`,[like,validImg],function(err,result){
            conn.query(`SELECT thumb FROM likes WHERE file = ?`,[validImg],function(err,result){
                res.json(result);

            });
        });
    } else {
        like -= 1;
        giveThumbUp = false;
        // $("#btn").css("background:url(\"../img/thumbUp.png\") no-repeat");
        conn.query(`UPDATE likes SET thumb = ? WHERE file =?`, [like, validImg], function (err, result) {
            conn.query(`SELECT thumb FROM likes WHERE file = ?`, [validImg], function (err, result) {
                var data = JSON.stringify(result);
                res.json(result);
                console.log("resultB is " + data);
            });
        })
    }

});

app.get("/goBack",function(req,res){
    conn.query(`SELECT * FROM images`,function(err,img){
        conn.query( `SELECT * FROM comments`,function(err,ctn){
            conn.query(`SELECT * FROM likes`,function(err,likes){
                var username=req.session.username;
                res.render("image.ejs",{"visitor":username,"imgDB":img,"ctnDB":ctn,"likes":likes});
            });
        })

    });
});


app.listen(port);