import React from 'react';
import { Circle, Square, Triangle } from 'lucide-react';
import './Spinner.css';

export const LoadingSpinner = () => {
	return (
		<main class='container'>
			<div class='spinner-container'>
				<Circle class='icon-spinner' style={{ animationDelay: '0s' }} />
				<Square class='icon-spinner' style={{ animationDelay: '0.2s' }} />
				<Triangle class='icon-spinner' style={{ animationDelay: '0.4s' }} />
			</div>
		</main>
	);
};
