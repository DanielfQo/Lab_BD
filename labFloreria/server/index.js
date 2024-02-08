const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");

app.use(cors());
app.use(express.json());

let usuario = "";
let contrasenia = "";
let userDb;

app.post("/verificar", (req, res) => {
    usuario = req.body.usuario;
    contrasenia = req.body.contrasenia;
    
    userDb = mysql.createConnection({
        host: "localhost",
        user: usuario,
        password: contrasenia,
        database: "labcine"
    });
    
    userDb.connect((err) => {
        if (err) {
            console.error("Error al conectar a la base de datos con las credenciales proporcionadas:", err);
            return res.status(401).json({ mensaje: "Credenciales incorrectas" });
        }

        console.log("Conexión exitosa con las credenciales proporcionadas");
        return res.status(200).json({ mensaje: "Conexión exitosa con las credenciales proporcionadas" });
    });
    
});

app.post("/insertar", (req, res) => {
    const titulo = req.body.titulo;
    const estudio = req.body.estudio;
    const clasificacion = req.body.clasificacion;
    const sinopsis = req.body.sinopsis;
    
    userDb.query('CALL InsertarPelicula(?,?,?,?)',[titulo,estudio,clasificacion,sinopsis],
    (err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            res.send("Pelicual registrada");
        }
    });
});


app.get("/reporte", (req, res) => {
    userDb.query("SELECT * FROM pelicula",
    (err,result)=>{
        if(err){
            console.log(err);
        }
        else{
            res.send(result);
        }
    });
});


app.listen(3001,()=>{
    console.log("Corriendo en el puerto 3001")
})
