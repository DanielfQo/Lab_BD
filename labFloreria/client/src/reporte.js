import './App.css';
import { useState } from "react";
import Axios from "axios";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useNavigate } from "react-router-dom";

const Reporte = () => {

    const [stock, setStock] = useState("");
    const [ciudad, setCiudad] = useState("");
    const [calle, setCalle] = useState("");
    const [numero, setNumero] = useState("");
    const [colonia, setColonia] = useState("");
    const [codigo_postal, setCodigoPostal] = useState("");


    const [tiendaList, setTiendas] = useState([]);

    const getTiendas = () => {
        Axios.get("http://localhost:3001/reporte").then((response) => {
            setTiendas(response.data);
        });
    }

    const insertar = () => {
        Axios.post("http://localhost:3001/insertar", {
            stock: stock,
            ciudad: ciudad,
            calle: calle,
            numero: numero,
            colonia: colonia,
            codigo_postal: codigo_postal
        })
            .then(() => {
                alert("Pelicula registrada");
            });
    }

    return (

        <>
            <div className="card text-center">
                <div className="card-header">
                    Insertar tienda
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Stock: </span>
                    <input type="text"
                        onChange={(event) => {
                            const inputValue = event.target.value;
                            const onlyNumbers = inputValue.replace(/[^0-9]/g, '');
                            setStock(onlyNumbers);
                        }}
                        value={stock}
                        className="form-control" placeholder="stock" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Ciudad: </span>
                    <input type="text"
                        onChange={(event) => {
                            setCiudad(event.target.value);
                        }}
                        className="form-control" placeholder="Ciudad" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Calle: </span>
                    <input type="text"
                        onChange={(event) => {
                            setCalle(event.target.value);
                        }}
                        className="form-control" placeholder="Calle" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Numero: </span>
                    <input type="text"
                        onChange={(event) => {
                            const inputValue = event.target.value;
                            const onlyNumbers = inputValue.replace(/[^0-9]/g, '');
                            setNumero(onlyNumbers);
                        }}
                        value={numero}
                        className="form-control" placeholder="numero" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Colonia: </span>
                    <input type="text"
                        onChange={(event) => {
                            setColonia(event.target.value);
                        }}
                        className="form-control" placeholder="Colonia" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="input-group mb-3">
                    <span className="input-group-text" id="basic-addon1">Codigo_postal: </span>
                    <input type="text"
                        onChange={(event) => {
                            const inputValue = event.target.value;
                            const onlyNumbers = inputValue.replace(/[^0-9]/g, '');
                            setCodigoPostal(onlyNumbers);
                        }}
                        value={codigo_postal}
                        className="form-control" placeholder="Codigo_postal" aria-label="Username" aria-describedby="basic-addon1" />
                </div>

                <div className="card-footer text-muted">
                    <button className='btn btn-success' onClick={insertar}>Insertar</button>
                </div>

            </div>


            <div className='lista'>
                <button onClick={getTiendas}>Listar</button>
            </div>

            <table className="table table-striped">

                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Stock</th>
                        <th scope="col">Ciudad</th>
                        <th scope="col">Calle</th>
                        <th scope="col">Numero</th>
                        <th scope="col">Colonia</th>
                        <th scope="col">Codigo_postal</th>
                    </tr>
                </thead>

                <tbody>
                    {
                        tiendaList.map((val, key) => {
                            return <tr key={val.tienda_ID}>
                                <th scope="row">{val.tienda_ID}</th>
                                <td>{val.stock}</td>
                                <td>{val.ciudad}</td>
                                <td>{val.calle}</td>
                                <td>{val.numero}</td>
                                <td>{val.colonia}</td>
                                <td>{val.codigo_postal}</td>
                            </tr>

                        })
                    }

                </tbody>

            </table>
        </>
    );
}

export default Reporte;