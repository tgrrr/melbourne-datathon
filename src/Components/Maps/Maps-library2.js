import React from 'react';
import propTypes from 'prop-types';
import { compose, withProps } from "recompose"
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"
import HeatmapLayer from "react-google-maps/lib/components/visualization/HeatmapLayer";
import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON';
// import crimesUnweightedJson from '../Data/crimes_unweightedJSON_object.js';

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
    
//    map.setCenter(new google.maps.LatLng(-34, 151));
//    map.setCenter({lat: -34, lng: 151}); 
  
  // const data = 
  // [
  //   new window({lat: -34, lng: 151}),
  // ]

  // const dataTres = crimesUnweightedJson.map((item) => (
  //   [new window.google.maps.LatLng(37.782745, 144.950098)]
  // )); 

  const result2 = [
    new window.google.maps.LatLng(-37.8232433, 144.950098),
    new window.google.maps.LatLng(-38.8232433, 144.950098),
  ]
  
  const result3 = ({0: window.google.maps.LatLng(-37.8232433, 144.950098) })
  
  return (
    <GoogleMap
      defaultZoom={8}
      defaultCenter={{
        lat: -37.8232433,
        lng: 144.950098,
      
      }}
    >
      
      {console.log('result2', result2)}
      {console.log('result2', typeof (result2))}
      
      {console.log('result3', result3)}
      {console.log('result3', typeof (result3))}
      
      {console.log('points', points)}
      {console.log('points', typeof (points))}
      
      {props.isMarkerShown && 
        <Marker 
          position={{      
            lat: -37.8232433,
            lng: 144.950098, 
          }} 
        />}
      {/* <AnyReactComponent 
        mapPoints = {crimesUnweightedJson} 
      /> */}
      <HeatmapLayer
        data={data}
      />
    </GoogleMap>
  );
});

export default MyMapComponent;