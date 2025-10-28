import type { ReactNode } from "react";




import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Servicios from "./pages/Servicios";
import PorQueElegirnos from "./pages/PorQueElegirnos";
import Premios from "./pages/Premios";
import Dashboard from "./pages/Dashboard";
import CrearCampania from "./pages/CrearCampania";
import RevisarCampania from "./pages/RevisarCampania";
import SolicitarCampania from "./pages/SolicitarCampania";
import ValidarPago from "./pages/ValidarPago";
import Login from "./pages/Login";
import Register from "./pages/Register";
import { AuthProvider, useAuth } from "./context/AuthContext";

function PrivateRoute({ children }: { children: ReactNode }) {
  const { user } = useAuth();
  return user ? <>{children}</> : <Navigate to="/login" replace />;
}

export default function App() {
  return (
    <AuthProvider>
      <Router>
        <div className="flex flex-col min-h-screen bg-bg text-text">
          <Navbar />
          <main className="flex-grow px-6 py-10">
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/servicios" element={<Servicios />} />
              <Route path="/por-que-elegirnos" element={<PorQueElegirnos />} />
              <Route path="/premios" element={<Premios />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
              <Route path="/crear-campania" element={<PrivateRoute><CrearCampania /></PrivateRoute>} />
              <Route path="/revisar-campania" element={<PrivateRoute><RevisarCampania /></PrivateRoute>} />
              <Route path="/solicitar-campania" element={<PrivateRoute><SolicitarCampania /></PrivateRoute>} />
              <Route path="/validar-pago" element={<PrivateRoute><ValidarPago /></PrivateRoute>} />
            </Routes>
          </main>
          <Footer />
        </div>
      </Router>
    </AuthProvider>
  );
}
