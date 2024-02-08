import './App.css';
import { useState } from "react";
import Axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from "react-router-dom";

const Reporte = () => {

    const [titulo, setTitulo] = useState("");
    const [estudio, setEstudio] = useState("");
    const [clasificacion, setClasificacion] = useState("");
    const [sinopsis, setSinopsis] = useState("");

    const [personaList, setPersonas] = useState([]);

    const getPersonas = () => {
        Axios.get("http://localhost:3001/reporte").then((response) => {
            setPersonas(response.data);
        });
    }

    const insertar = () => {
        Axios.post("http://localhost:3001/insertar", {
            titulo: titulo,
            estudio: estudio,
            clasificacion: clasificacion,
            sinopsis: sinopsis
        })
            .then(() => {
                alert("Pelicula registrada");
            });
    }

    return (

        <>
            <div className="card text-center">
                <div className="card-header">
                    Insertar pelicula
                </div>

                <div className="card-body">
                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Titulo: </span>
                        <input type="text"
                            onChange={(event) => {
                                setTitulo(event.target.value);
                            }}
                            className="form-control" placeholder="Title" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Estudio: </span>
                        <input type="text"
                            onChange={(event) => {
                                setEstudio(event.target.value);
                            }}
                            className="form-control" placeholder="Estudio" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <label className="input-group-text" htmlFor="clasificacion">Clasificación:</label>
                        <select
                            className="form-select"
                            id="clasificacion"
                            onChange={(event) => {
                                setClasificacion(event.target.value);
                            }}
                            defaultValue=""
                        >
                            <option value="" disabled hidden>Selecciona una clasificación</option>
                            <option value="G">G</option>
                            <option value="PG">PG</option>
                            <option value="PG-13">PG-13</option>
                            <option value="R">R</option>
                            <option value="NC-17">NC-17</option>
                        </select>
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Sinopsis: </span>
                        <input type="text"
                            onChange={(event) => {
                                setSinopsis(event.target.value);
                            }}
                            className="form-control" placeholder="Sinopsis" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                </div>

                <div className="card-footer text-muted">
                    <button className='btn btn-success' onClick={insertar}>Insertar</button>
                </div>

            </div>


            <div className='lista'>
                <button onClick={getPersonas}>Listar</button>
            </div>

            <table className="table table-striped">

                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Titulo</th>
                        <th scope="col">Estudio</th>
                        <th scope="col">Clasificacion</th>
                        <th scope="col">Sinopsis</th>
                    </tr>
                </thead>

                <tbody>
                    {
                        personaList.map((val, key) => {
                            return <tr key={val.pelicula_ID}>
                                <th scope="row">{val.pelicula_ID}</th>
                                <td>{val.titulo}</td>
                                <td>{val.estudio}</td>
                                <td>{val.clasificacion}</td>
                                <td>{val.sinopsis}</td>
                            </tr>

                        })
                    }

                </tbody>

            </table>
        </>
    );
}

export default Reporte;