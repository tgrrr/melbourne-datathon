import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import Plotly from '../Plotly/Plotly.js';
import { heatmapData } from '../../data/fakeData';

// var heatmapData = [
//   new google.maps.LatLng(37.782, -122.447),
//   new google.maps.LatLng(37.782, -122.445),
//   new google.maps.LatLng(37.782, -122.443),
//   new google.maps.LatLng(37.782, -122.441),
//   new google.maps.LatLng(37.782, -122.439),
//   new google.maps.LatLng(37.782, -122.437),
//   new google.maps.LatLng(37.782, -122.435),
//   new google.maps.LatLng(37.785, -122.447),
//   new google.maps.LatLng(37.785, -122.445),
//   new google.maps.LatLng(37.785, -122.443),
//   new google.maps.LatLng(37.785, -122.441),
//   new google.maps.LatLng(37.785, -122.439),
//   new google.maps.LatLng(37.785, -122.437),
//   new google.maps.LatLng(37.785, -122.435)
// ];

const AnyReactComponent = ({ text }) => <div>{text}</div>;

class HeatMap extends Component {
  static defaultProps = {
    center: {
      lat: 60.714305,
      lng: 47.051773,
    },
    zoom: 12
  };

  render() {
    // console.log('heatmapData', heatmapData);
    return (
      // Important! Always set the container height explicitly
      <div style={{ height: '100vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: process.env.REACT_APP_GOOGLE_MAPS }}
          defaultCenter={this.props.center}
          defaultZoom={this.props.zoom}
          layerTypes={['TrafficLayer', 'TransitLayer']}
          heatmapLibrary={true}
          heatmap={heatmapData}
          // heatmap={heatmapData}
        >
          {/* <Plotly /> */}
          <AnyReactComponent />
        </GoogleMapReact>
      </div>
    );
  }
}

export default HeatMap;
