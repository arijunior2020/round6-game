import React from 'react';
import { Circle, Square, Triangle } from 'lucide-react';
import './Geometric.css';

export const Geometric = () => {
	return (
		<div class='grid'>
			{Array.from({
				length: 48,
			}).map((_, index) => {
				const Icon =
					index % 3 === 0 ? Circle : index % 3 === 1 ? Square : Triangle;
				return (
					<div key={index} class='aspect'>
						<Icon
							class='icon'
							style={{
								opacity: index % 2 === 0 ? 0.9 : 0.7,
							}}
						/>
					</div>
				);
			})}
		</div>
	);
};
