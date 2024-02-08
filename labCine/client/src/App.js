
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import './App.css';
import Login from './Login';
import Reporte from './reporte';

function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login/>}/>
        <Route path="/reporte" element={<Reporte/>}/>
      </Routes>
  
    </BrowserRouter>
  
  );
}

export default App;
