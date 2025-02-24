import React, { useState, useEffect } from "react";
import "./App.css";

function LuzVermelha({ voltar }) {
    const [posicao, setPosicao] = useState(0);
    const [cor, setCor] = useState("verde");

    useEffect(() => {
        const interval = setInterval(() => {
            setCor(cor === "verde" ? "vermelha" : "verde");
        }, 2000);
        return () => clearInterval(interval);
    }, [cor]);

    const mover = () => {
        if (cor === "verde") {
            setPosicao(posicao + 10);
            if (posicao >= 100) alert("Parabéns, você venceu a fase!");
        } else {
            alert("Você foi pego! Tente novamente.");
            setPosicao(0);
        }
    };

    return (
        <div>
            <h2>Fase: Luz Vermelha, Luz Verde</h2>
            <p className={`luz-vermelha ${cor}`}>{cor.toUpperCase()}</p>
            <button onClick={mover}>Andar</button>
            <button onClick={voltar}>Voltar ao Menu</button>
        </div>
    );
}

export default LuzVermelha;
