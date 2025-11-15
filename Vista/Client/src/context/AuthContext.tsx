import React, { createContext, useContext, useState, useEffect } from "react";
import type { ReactNode } from "react";

interface User {
  usu_id: number;
  usu_nombre: string;
  usu_apellido: string;
  usu_email: string;
  usu_rol: string;
  usu_estado: string;
  usu_cli_id: number;
  usu_telefono?: string;
  cli_nombre_empresa?: string;
}

interface AuthContextType {
  user: User | null;
  login: (userData: User) => void;
  logout: () => void;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  // Verificar si hay sesión guardada al cargar
  useEffect(() => {
    const savedUser = localStorage.getItem("usuario");
    
    if (savedUser) {
      try {
        const parsedUser = JSON.parse(savedUser);
        console.log("✅ Usuario cargado desde localStorage:", parsedUser);
        setUser(parsedUser);
      } catch (error) {
        console.error("❌ Error al parsear usuario:", error);
        localStorage.removeItem("usuario");
      }
    } else {
      console.log("ℹ️ No hay usuario guardado en localStorage");
    }
    
    setIsLoading(false);
  }, []);

  const login = (userData: User) => {
    console.log("🔐 Login ejecutado con usuario:", userData);
    
    // Guardar en estado
    setUser(userData);
    
    // Guardar en localStorage
    localStorage.setItem("usuario", JSON.stringify(userData));
    
    console.log("✅ Usuario guardado en localStorage");
  };

  const logout = () => {
    console.log("🚪 Logout ejecutado");
    
    // Limpiar estado
    setUser(null);
    
    // Limpiar localStorage
    localStorage.removeItem("usuario");
    
    console.log("✅ Usuario eliminado de localStorage");
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  
  if (!context) {
    throw new Error("useAuth debe ser usado dentro de un AuthProvider");
  }
  
  return context;
}