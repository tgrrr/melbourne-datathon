import React from 'react';
import propTypes from 'prop-types';
import GoogleMapReact from 'google-map-react';
// import Plotly from '../Plotly/Plotly.js';

const AnyReactComponent = ({ text }) => <div>{text}</div>;

const center = {
  lat: -37.8232433,
  lng: 144.950098,
}

const zoom = 10

const createMapOptions = (maps) => {
    return {
      panControl: false,
      mapTypeControl: false,
      scrollwheel: false,
      styles: [{ stylers: [{ 'saturation': -100 }, { 'gamma': 0.8 }, { 'lightness': 4 }, { 'visibility': 'on' }] }]
    }
  }

const Heatmap = ({heatmapData}) => (

  // Important! Always set the container height explicitly
  <div style={{ height: '100vh', width: '100%' }}>
    <GoogleMapReact
      bootstrapURLKeys={{ key: process.env.REACT_APP_GOOGLE_MAPS }}
      defaultCenter={center}
      defaultZoom={zoom}
      options={createMapOptions}
      layerTypes={['TransitLayer']}
      heatmapLibrary={true}
      heatmap = { heatmapData }
      
    >
      
      <AnyReactComponent
        lat={-37.8232433}
        lng={144.950098}
        text={'Demo text'}
      />
    </GoogleMapReact>
  </div>
);

Heatmap.propTypes = {
  center: propTypes.objectOf(propTypes.number), 
    lat: propTypes.number,
    lng: propTypes.number,
  zoom: propTypes.number,
};

Heatmap.defaultProps = {
  centre: {
    lat: -37.8232433,
    lng: 144.950098,
  },
  zoom: 12
};


export default Heatmap;
