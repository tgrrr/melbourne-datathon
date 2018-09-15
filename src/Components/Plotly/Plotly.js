import React from 'react';
import Plot from 'react-plotlyjs';


const plotlyData = [
  {
    x: [1, 2, 3],
    y: [2, 6, 3],
    type: 'scatter',
    mode: 'lines+points',
    marker: {color: 'red'},
  },
  {
    type: 'bar', 
    x: [1, 2, 3], 
    y: [2, 5, 3]
  },
];

const plotlyLayout = {
  width: 320, 
  height: 240, 
  title: 'A Fancy Plot',
}

const Plotly = () => (
  <div>
    <Plot
      data = {plotlyData}
      layout = {plotlyLayout}
    />
  </div>
);

export default Plotly;
