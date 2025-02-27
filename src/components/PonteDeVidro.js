import React, { useState } from 'react';
import './App.css';

function PonteDeVidro({ voltar }) {
	const [posicao, setPosicao] = useState(0);
	const [plataformas] = useState(['safe', 'danger', 'safe', 'danger', 'safe']);

	const pular = () => {
		if (plataformas[posicao] === 'safe') {
			setPosicao(posicao + 1);
			if (posicao >= plataformas.length - 1) {
				alert('Parabéns! Você atravessou a ponte!');
			}
		} else {
			alert('Você caiu! Tente novamente.');
			setPosicao(0);
		}
	};

	return (
		<div class='game-running-container'>
			<h2>Fase: Ponte de Vidro</h2>
			<div
				className='grid'
				class='game-running-buttons'
				style={{ gap: 20, margin: 20 }}>
				{plataformas.map((tipo, index) => (
					<div
						key={index}
						className={`card ${index === posicao ? 'flipped' : ''}`}>
						{index === posicao ? '⬆️' : ''}
					</div>
				))}
			</div>
			<button onClick={pular}>Pular</button>
			<button class='return' onClick={voltar}>
				Voltar ao Menu
			</button>
		</div>
	);
}

export default PonteDeVidro;
