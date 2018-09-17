import React from 'react';

const MapPoints = ({ mapPoints }) => (
  <ul>
    {console.log('props', mapPoints)}
    {mapPoints
      ? mapPoints.positions.map((point, i) => (<li key={i}>{JSON.stringify(point)}</li>))
      : null
    }
  </ul>
);

export default MapPoints;