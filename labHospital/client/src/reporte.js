import './App.css';
import { useState } from "react";
import Axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from "react-router-dom";

const Reporte = () => {

    const [nombre, setNombre] = useState("");
    const [tasa_mortalidad, setTasaMortalidad] = useState("");

    const [enfermedadList, setEnfermedades] = useState([]);

    const getEnfermedad = () => {
        Axios.get("http://localhost:3001/reporte").then((response) => {
            setEnfermedades(response.data);
        });
    }

    const insertar = () => {
        Axios.post("http://localhost:3001/insertar", {
            nombre: nombre,
            tasa_mortalidad: tasa_mortalidad,
        })
            .then(() => {
                alert("Pelicula registrada");
            });
    }

    return (

        <>
            <div className="card text-center">
                <div className="card-header">
                    Insertar hospital
                </div>

                <div className="card-body">
                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Nombre: </span>
                        <input type="text"
                            onChange={(event) => {
                                setNombre(event.target.value);
                            }}
                            className="form-control" placeholder="Nombre" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Tasa_mortalidad: </span>
                        <input type="text"
                            onChange={(event) => {
                                const inputValue = event.target.value;
                                const onlyNumbers = inputValue.replace(/[^0-9]/g, '');
                                setTasaMortalidad(onlyNumbers);
                            }}
                            value={tasa_mortalidad}
                            className="form-control" placeholder="tasa_mortalidad" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>
                </div>

                <div className="card-footer text-muted">
                    <button className='btn btn-success' onClick={insertar}>Insertar</button>
                </div>

            </div>


            <div className='lista'>
                <button onClick={getEnfermedad}>Listar</button>
            </div>

            <table className="table table-striped">

                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Tasa_mortalidad</th>
                    </tr>
                </thead>

                <tbody>
                    {
                        enfermedadList.map((val, key) => {
                            return <tr key={val.enfermedad_ID}>
                                <th scope="row">{val.enfermedad_ID}</th>
                                <td>{val.nombre}</td>
                                <td>{val.tasa_mortalidad}</td>
                            </tr>

                        })
                    }

                </tbody>

            </table>
        </>
    );
}

export default Reporte;