import React from 'react';
import propTypes from 'prop-types';
import { compose, withProps } from "recompose"
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"
import HeatmapLayer from "react-google-maps/lib/components/visualization/HeatmapLayer";
import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON';
// import crimesUnweightedJson from '../Data/crimes_unweightedJSON_object.js';
import { users } from '../Data/user_shortdata.js';

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
    
    
    
  const data2 = () => {
    return(new window.google.maps.LatLng({lat:-37.8232433, lng:144.950098}))
  };
    
  const result = crimesUnweightedJson.positions.map(
    // new window.google.maps.LatLng(-37.8232433, 144.950098),

    position => ({ lat: position.lat, lng: position.lng })
  );

  const points = [
    {location:[-1.131592, 52.629729], weight: 2},
    {location:[-1.141592, 52.629729], weight: 3},
    {location:[-1.161592, 53.629729], weight: 1},
  ]
    
  const data = 
  [
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-37.8232433, 144.950098),
  ]

  var heatMapData = [
    {location: new window.google.maps.LatLng(37.782, -122.447), weight: 0.5},
    new window.google.maps.LatLng(37.782, -122.445),
    {location: new window.google.maps.LatLng(37.782, -122.443), weight: 2},
    {location: new window.google.maps.LatLng(37.782, -122.441), weight: 3},
    {location: new window.google.maps.LatLng(37.782, -122.439), weight: 2},
    new window.google.maps.LatLng(37.782, -122.437),
    {location: new window.google.maps.LatLng(37.782, -122.435), weight: 0.5},

    {location: new window.google.maps.LatLng(37.785, -122.447), weight: 3},
    {location: new window.google.maps.LatLng(37.785, -122.445), weight: 2},
    new window.google.maps.LatLng(37.785, -122.443),
    {location: new window.google.maps.LatLng(37.785, -122.441), weight: 0.5},
    new window.google.maps.LatLng(37.785, -122.439),
    {location: new window.google.maps.LatLng(37.785, -122.437), weight: 2},
    {location: new window.google.maps.LatLng(37.785, -122.435), weight: 3}
  ];

  const result2 = [
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-38.8232433, 144.950098),
  ]
  
  const result3 = ({0: window.google.maps.LatLng(-37.8232433, 144.950098) })
  
  const gradientYarp = [
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

      {console.log('users', users[1])}
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
        data={heatMapData}
        options={{
          opacity: 1, 
          radius: 5, 
          maxIntensity: 1,
          gradient: gradientYarp
        }}
      />
    </GoogleMap>
  );
});

export default MyMapComponent;