import React, { useState, useEffect } from 'react';
import LuzVermelha from './components/LuzVermelha.js';
import Dalgona from './components/Dalgona.js';
import PonteDeVidro from './components/PonteDeVidro.js';
import { Geometric } from './components/Geometric.js';
import { LoadingSpinner } from './components/Spinner.js';
import './components/App.css';

export function App() {
	const [fase, setFase] = useState(null);
	const [loadingPhase, setLoadingPhase] = useState('loading');

	useEffect(() => {
		// Phase 1: Loading spinner (2 seconds)
		const loadingTimer = setTimeout(() => {
			setLoadingPhase('message');
		}, 2000);

		// Phase 2: "Let the game begin" message (2 seconds)
		const messageTimer = setTimeout(() => {
			setLoadingPhase('content');
		}, 4000);

		return () => {
			clearTimeout(loadingTimer);
			clearTimeout(messageTimer);
		};
	}, []);

	const renderContent = () => {
		switch (loadingPhase) {
			case 'loading':
				return <LoadingSpinner />;
			case 'message':
				return (
					<div class='app-container animate-fade-in'>
						<p class='message'>Vamos jogar?</p>
					</div>
				);
			case 'content':
				return (
					<main className='App' class='app-container'>
						<div class='pattern-container'>
							<Geometric />
						</div>
						<div class='game-container'>
							<h1 class='game-title'>Round 6 - Sem Violência</h1>
							<h2>Jogador 456</h2>
							<div class='buttons-container'>
								{!fase && (
									<div>
										<button onClick={() => setFase('luz-verde')}>
											Luz Vermelha, Luz Verde
										</button>
										<button onClick={() => setFase('dalgona')}>
											Desafio do Dalgona
										</button>
										<button onClick={() => setFase('ponte')}>
											Ponte de Vidro
										</button>
									</div>
								)}
								{fase === 'luz-verde' && (
									<LuzVermelha voltar={() => setFase(null)} />
								)}
								{fase === 'dalgona' && <Dalgona voltar={() => setFase(null)} />}
								{fase === 'ponte' && (
									<PonteDeVidro voltar={() => setFase(null)} />
								)}
							</div>
						</div>
					</main>
				);
			default:
				return null;
		}
	};

	return renderContent();
}
