import React, { useState } from "react";
import LuzVermelha from "./LuzVermelha";
import Dalgona from "./Dalgona";
import PonteDeVidro from "./PonteDeVidro";
import "./App.css";

function App() {
  const [fase, setFase] = useState(null);

  return (
    <div className="App">
      <h1>Jogo Round 6 - Sem Violência</h1>
      {!fase && (
        <div>
          <button onClick={() => setFase("luz-verde")}>Luz Vermelha, Luz Verde</button>
          <button onClick={() => setFase("dalgona")}>Desafio do Dalgona</button>
          <button onClick={() => setFase("ponte")}>Ponte de Vidro</button>
        </div>
      )}
      {fase === "luz-verde" && <LuzVermelha voltar={() => setFase(null)} />}
      {fase === "dalgona" && <Dalgona voltar={() => setFase(null)} />}
      {fase === "ponte" && <PonteDeVidro voltar={() => setFase(null)} />}
    </div>
  );
}

export default App;
