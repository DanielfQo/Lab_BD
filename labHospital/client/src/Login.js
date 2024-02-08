
import './App.css';
import { useState } from "react";
import Axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from "react-router-dom";


const Login = () => {

  const [usuario, setUsuario] = useState("");
  const [contrasenia, setConstrasenia] = useState("");

  const navigate = useNavigate()

  const send = () => {
    Axios.post("http://localhost:3001/verificar", {
      usuario: usuario,
      contrasenia: contrasenia
    })
      .then(() => {
        alert("Sesión Iniciada");
        navigate('/reporte')
      })
      .catch((error) => {
        console.error("Error en la autenticación:", error);
        alert("Credenciales incorrectas");
      });
  }

  return (
    <>
      <div className="container">
        <div className="Login">
          <h1 className="titulo">Sistema Hospital</h1>
        </div>

        <div className="card text-center">
          <div className="card-header">
            Iniciar sesion
          </div>

          <div className="card-body">
            <div className="input-group mb-3">
              <span className="input-group-text" id="basic-addon1">Titulo: </span>
              <input type="text"
                onChange={(event) => {
                  setUsuario(event.target.value);
                }}
                className="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" />
            </div>

            <div className="input-group mb-3">
              <span className="input-group-text" id="basic-addon1">Contraseña: </span>
              <input type="password"
                onChange={(event) => {
                  setConstrasenia(event.target.value);
                }}
                className="form-control" placeholder="Password" aria-label="Username" aria-describedby="basic-addon1" />
            </div>

          </div>

          <div className="card-footer text-muted">
            <button className='btn btn-success' onClick={send}>Enviar</button>
          </div>
        </div>
      </div>
    </>
  );
}

export default Login;
