import React, { useState } from 'react';

function Dalgona({ voltar }) {
	const [cliques, setCliques] = useState(0);
	const [fim, setFim] = useState(false);

	const cortar = () => {
		setCliques(cliques + 1);
		if (cliques >= 10) {
			setFim(true);
			alert('Você completou o desenho!');
		}
	};

	return (
		<div class='game-running-container'>
			<h2>Fase: Desafio do Dalgona</h2>
			{!fim ? (
				<button onClick={cortar}>Clique para recortar ({cliques}/10)</button>
			) : (
				<button onClick={voltar}>Voltar ao Menu</button>
			)}
		</div>
	);
}

export default Dalgona;
