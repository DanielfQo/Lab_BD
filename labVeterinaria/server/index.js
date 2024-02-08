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
        database: "labveterinaria"
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
    const nombres = req.body.nombres;
    const prim_apellido = req.body.prim_apellido;
    const seg_apellido = req.body.seg_apellido;
    const edad = req.body.edad;
    const nacionalidad = req.body.nacionalidad;
    const direccion = req.body.direccion;
    const genero = req.body.genero;

    userDb.query('INSERT INTO persona (nombres, prim_apellido, seg_apellido, edad, nacionalidad, direccion, genero) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [nombres, prim_apellido, seg_apellido, edad, nacionalidad, direccion, genero],
        (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).send("Error al insertar la persona");
            } else {
                console.log("Usuario registrado correctamente");
                res.status(200).send("Persona registrado correctamente");
            }
        });
});



app.get("/reporte", (req, res) => {
    userDb.query("SELECT * FROM persona",
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
