import React from 'react';
import propTypes from 'prop-types';
import GoogleMapReact from 'google-map-react';
// import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON';

import './maps.css';

const Marker = ({ text }) => <div className="marker__basic">{text}</div>;

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

const Heatmap = ({heatmapData}) => {

  return (
    // Important! Always set the container height explicitly
    <div style={{ height: '100vh', width: '100%' }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: process.env.REACT_APP_GOOGLE_MAPS }}
        defaultCenter={center}
        defaultZoom={zoom}
        options={createMapOptions}
        layerTypes={['TransitLayer']}
        heatmapLibrary={true}
        heatmap = {heatmapData}
      >
        <Marker
          // position={{ lat: -37.8232433, lng: -37.8232433 }}
          lat = "-37.8232433"
          lng = "144.950098"
          // key = {i}
          text = "X"
        />

        {/* {crimesUnweightedJson.positions.map((point, i) => (
        <Marker
          // mapPoints = {crimesUnweightedJson}
          // position={{ lat: point.lat, lng: point.lng }}
          lat = {point.lat}
          lng = {point.lng}
          key = {i}
          text = "."
        />))} */}
        
        {/* <AnyReactComponent
          lat={-37.8232433}
          lng={144.950098}
          mapPoints={crimesUnweightedJson}
        /> */}
      </GoogleMapReact>
    </div>
  )
}
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
