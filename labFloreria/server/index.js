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
        database: "labfloreria"
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
    const stock = req.body.stock;
    const ciudad = req.body.ciudad;
    const calle = req.body.calle;
    const numero = req.body.numero;
    const colonia = req.body.colonia;
    const codigo_postal = req.body.codigo_postal;
    
    userDb.query('INSERT INTO tienda(stock, ciudad, calle, numero, colonia, codigo_postal) VALUES (?, ?, ?, ?, ?, ?)',
    [stock, ciudad, calle, numero, colonia, codigo_postal],
    (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send("Error al insertar en la base de datos");
        } else {
            console.log("Tienda registrada");
            res.status(200).send("Tienda registrada");
        }
    });
});

app.get("/reporte", (req, res) => {
    userDb.query("SELECT * FROM tienda",
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
