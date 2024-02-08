import './App.css';
import { useState } from "react";
import Axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from "react-router-dom";

const Reporte = () => {

    const [nombres, setNombres] = useState("");
    const [prim_apellido, setPrim_apellido] = useState("");
    const [seg_apellido, setSeg_apellido] = useState("");
    const [edad, setEdad] = useState("");
    const [nacionalidad, setNacionalidad] = useState("");
    const [direccion, setDireccion] = useState("");
    const [genero, setGenero] = useState("");

    const [personaList, setPersonas] = useState([]);

    const getPersonas = () => {
        Axios.get("http://localhost:3001/reporte").then((response) => {
            setPersonas(response.data);
        });
    }

    const insertar = () => {
        Axios.post("http://localhost:3001/insertar", {
            nombres: nombres,
            prim_apellido: prim_apellido,
            seg_apellido: seg_apellido,
            edad: edad,
            nacionalidad:nacionalidad,
            direccion:direccion,
            genero:genero
        })
            .then(() => {
                alert("Persona registrada");
            });
    }

    return (

        <>
            <div className="card text-center">
                <div className="card-header">
                    Insertar persona
                </div>

                <div className="card-body">
                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Nombres: </span>
                        <input type="text"
                            onChange={(event) => {
                                setNombres(event.target.value);
                            }}
                            className="form-control" placeholder="Nombres" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">1°apellido: </span>
                        <input type="text"
                            onChange={(event) => {
                                setPrim_apellido(event.target.value);
                            }}
                            className="form-control" placeholder="prim_apellido" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">2°apellido: </span>
                        <input type="text"
                            onChange={(event) => {
                                setSeg_apellido(event.target.value);
                            }}
                            className="form-control" placeholder="seg_apellido" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Edad: </span>
                        <input type="text"
                            onChange={(event) => {
                                const inputValue = event.target.value;
                                const onlyNumbers = inputValue.replace(/[^0-9]/g, '');
                                setEdad(onlyNumbers);
                            }}
                            value={edad}
                            className="form-control" placeholder="edad" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Nacionalidad: </span>
                        <input type="text"
                            onChange={(event) => {
                                setNacionalidad(event.target.value);
                            }}
                            className="form-control" placeholder="nacionalidad" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <span className="input-group-text" id="basic-addon1">Direccion: </span>
                        <input type="text"
                            onChange={(event) => {
                                setDireccion(event.target.value);
                            }}
                            className="form-control" placeholder="direccion" aria-label="Username" aria-describedby="basic-addon1" />
                    </div>

                    <div className="input-group mb-3">
                        <label className="input-group-text" htmlFor="genero">Genero:</label>
                        <select
                            className="form-select"
                            id="genero"
                            onChange={(event) => {
                                setGenero(event.target.value);
                            }}
                            defaultValue=""
                        >
                            <option value="" disabled hidden>Selecciona un genero</option>
                            <option value="masculino">masculino</option>
                            <option value="femenino">femenino</option>
                        </select>
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
                        <th scope="col">Nombres</th>
                        <th scope="col">1°apellido</th>
                        <th scope="col">2°apellido</th>
                        <th scope="col">edad</th>
                        <th scope="col">nacionalidad</th>
                        <th scope="col">direccion</th>
                        <th scope="col">genero</th>
                        
                    </tr>
                </thead>

                <tbody>
                    {
                        personaList.map((val, key) => {
                            return <tr key={val.persona_ID}>
                                <th scope="row">{val.persona_ID}</th>
                                <td>{val.nombres}</td>
                                <td>{val.prim_apellido}</td>
                                <td>{val.seg_apellido}</td>
                                <td>{val.edad}</td>
                                <td>{val.nacionalidad}</td>
                                <td>{val.direccion}</td>
                                <td>{val.genero}</td>
                            </tr>

                        })
                    }

                </tbody>

            </table>
        </>
    );
}

export default Reporte;