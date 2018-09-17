import React from 'react';
import propTypes from 'prop-types';
import { compose, withProps } from "recompose"
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"
import HeatmapLayer from "react-google-maps/lib/components/visualization/HeatmapLayer";
import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON';
// import crimesUnweightedJson from '../Data/crimes_unweightedJSON_object.js';
import { users } from '../Data/user_shortdata.js';
// import crimes from '../Data/crimesNormalised2.js';
const { MarkerClusterer } = require("react-google-maps/lib/components/addons/MarkerClusterer");

const AnyReactComponent = ({mapPoints}) => (
    mapPoints.positions.map((point, i) => (
    <MapPoints 
      // mapPoints = {crimesUnweightedJson}
      lat = {point.lat}
      lng = {point.lng}
      key = {i}
      text = "X"
    />))
)

const MapPoints = () => (
  <div>Y</div>
)

const MyMapComponent = compose(
  withProps({
    googleMapURL: "https://maps.googleapis.com/maps/api/js?key=AIzaSyCe8mWSx7ug0O4YsOAGgsS9imt3RUQytLU&v=3.exp&libraries=geometry,drawing,places,visualization",
    loadingElement: <div style={{ height: `100%` }} />,
    containerElement: <div style={{ height: `400px` }} />,
    mapElement: <div style={{ height: `100%` }} />,
  }),
  withScriptjs,
  withGoogleMap
)((props) => {
  // const NewWindowGoogleThingy = 
  //   crimesUnweightedJson.map(point => (
  //     {location: new window.google.maps.LatLng(point['location'][1], point['location'][0]),
  //     weight: point['weight']}))

    // new window.google.maps.LatLng(37.782745, 144.950098)

    // const dataDuo = ({crimesUnweightedJson}) => (
    //   <div>
    //     {crimesWeightedJson.map((item) => {
    //       <div>{item}</div>
    //     })}
    //   </div>
    //   // crimesWeightedJson.map((item) => {
    //   //   item[0]
    //   // })
    // );

  const gradientColor = [
          'rgba(0, 255, 255, 0)',
          'rgba(0, 255, 255, 1)',
          'rgba(0, 191, 255, 1)',
          'rgba(0, 127, 255, 1)',
          'rgba(0, 63, 255, 1)',
          'rgba(0, 0, 255, 1)',
          'rgba(0, 0, 223, 1)',
          'rgba(0, 0, 191, 1)',
          'rgba(0, 0, 159, 1)',
          'rgba(0, 0, 127, 1)',
          'rgba(63, 0, 91, 1)',
          'rgba(127, 0, 63, 1)',
          'rgba(191, 0, 31, 1)',
          'rgba(255, 0, 0, 1)'
        ]
  
        // import crimes from '../Data/crimesNormalised2.js';
        const crimes = require('../Data/crimesHeatmap.js')

  
  return (
    <GoogleMap
      defaultZoom={8}
      defaultCenter={{
        lat: -37.8232433,
        lng: 144.950098,
      
      }}
    >
    <MapPoints 
      position={{      
        lat: -37.748502,
        lng: 144.9566502, 
      }} 
    />

      {console.log('user', users[1])}

      {console.log('crimes', crimes.default)}
      {users.map((user) => {
        <MapPoints 
          position={{      
            lat: user.lat,
            lng: user.lng, 
          }} 
        />
        })}
      
      {/* {props.isMarkerShown && 
        <Marker 
          position={{      
            lat: -37.8232433,
            lng: 144.950098, 
          }} 
        />} */}
      {/* <AnyReactComponent 
        mapPoints = {crimesUnweightedJson} 
      /> */}
      <HeatmapLayer
        data={crimes.default}
        options={{
          opacity: 1, 
          radius: 3, 
          maxIntensity: 5,
          gradient: gradientColor
        }}
      />
      {/* <MarkerClusterer
        onClick={props.onMarkerClustererClick}
        averageCenter
        enableRetinaIcons
        gridSize={60}
      >
        {users.map(marker => (
          <Marker
            key={marker.id}
            position={{ lat: marker.lat, lng: marker.lon }}
          />
        ))}
      </MarkerClusterer> */}
      
    </GoogleMap>
  );
});

export default MyMapComponent;