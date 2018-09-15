import React from 'react';

const MapCoordinates = ({mapPoints}) => (
  <ul>
    {mapPoints 
      ? mapPoints.map((point, i) => (<li key={i}>{JSON.stringify(point)}</li>))
      : null
    }
  </ul>
);

export default MapCoordinates;