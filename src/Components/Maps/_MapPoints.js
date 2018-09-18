import React from 'react';

const _MapPoints = ({ mapPoints }) => (
  <ul>
    {console.log('props', mapPoints)}
    {mapPoints
      ? mapPoints.positions.map((point, i) => (<li key={i}>{JSON.stringify(point)}</li>))
      : null
    }
  </ul>
);

export default _MapPoints;

// const AnyReactComponent = ({mapPoints}) => (
//     mapPoints.positions.map((point, i) => (
//     <MapPoints 
//       // mapPoints = {crimesUnweightedJson}
//       lat = {point.lat}
//       lng = {point.lng}
//       key = {i}
//       text = "X"
//     />))
// )

const MapPoints2 = () => (
  <div>Y</div>
)
