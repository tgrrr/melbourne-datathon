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

  const crimesLocal = [
    {location: new window.google.maps.LatLng( -37.689596 ,  145.105088 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.686742 ,  145.105588 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.683643 ,  145.108743 ), weight:  0.0557790835563198 },
    {location: new window.google.maps.LatLng( -37.682591 ,  145.111331 ), weight:  0.0557790835563198 },
    {location: new window.google.maps.LatLng( -37.685336 ,  145.117319 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.682753 ,  145.119615 ), weight:  0.0557790835563198 },
    {location: new window.google.maps.LatLng( -37.73643 ,  145.04445 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.72242 ,  145.04811 ), weight:  0.560636707173214 },
    {location: new window.google.maps.LatLng( -37.741638 ,  145.043435 ), weight:  0.622107533949566 },
    {location: new window.google.maps.LatLng( -37.742127 ,  145.048189 ), weight:  0.622107533949566 },
    {location: new window.google.maps.LatLng( -37.746456 ,  145.058616 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.744544 ,  145.062009 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.743721 ,  145.063431 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.743181 ,  145.066575 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.744839 ,  145.067475 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.745094 ,  145.070129 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.742912 ,  145.073276 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.743214 ,  145.075997 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.74211 ,  145.078487 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.743278 ,  145.083568 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.744235 ,  145.088598 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.742262 ,  145.090096 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.740204 ,  145.089902 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.739581 ,  145.090789 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.738024 ,  145.091014 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.736714 ,  145.090671 ), weight:  0.474691384550721 },
    {location: new window.google.maps.LatLng( -37.733071 ,  145.091141 ), weight:  0.0295970647441697 },
    {location: new window.google.maps.LatLng( -37.73242 ,  145.08715 ), weight:  0.0295970647441697 },
    {location: new window.google.maps.LatLng( -37.729606 ,  145.09222 ), weight:  0.0295970647441697 },
    {location: new window.google.maps.LatLng( -37.728816 ,  145.096155 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.729119 ,  145.101309 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.728368 ,  145.101745 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.725426 ,  145.104122 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.723613 ,  145.104235 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.7211 ,  145.10388 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.71786 ,  145.104444 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.716864 ,  145.101751 ), weight:  0.105297249570604 },
    {location: new window.google.maps.LatLng( -37.715024 ,  145.101526 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.71375 ,  145.10174 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.711867 ,  145.102066 ), weight:  0.304508262271746 },
    {location: new window.google.maps.LatLng( -37.806212 ,  144.884835 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.785635 ,  144.8757 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.787155 ,  144.879375 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.788376 ,  144.882364 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.789661 ,  144.885443 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.7921 ,  144.88931 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.79495 ,  144.88874 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.796555 ,  144.8885 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.798444 ,  144.888149 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.79883 ,  144.891256 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.79948 ,  144.89302 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.800493 ,  144.895672 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.783385 ,  144.864948 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.786079 ,  144.864418 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.788974 ,  144.863923 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.79137 ,  144.863476 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.793728 ,  144.86298 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.795864 ,  144.862978 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.796221 ,  144.866201 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.796509 ,  144.869371 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.79689 ,  144.87221 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.797085 ,  144.874197 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.797391 ,  144.878114 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.797866 ,  144.880823 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.798234 ,  144.884493 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.798612 ,  144.887705 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.798785 ,  144.893129 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.802782 ,  144.8988 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.80463 ,  144.902092 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.805278 ,  144.904628 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.790153 ,  144.899978 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.790865 ,  144.89484 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.7948 ,  144.895429 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.79687 ,  144.897326 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.799207 ,  144.899141 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.802944 ,  144.891225 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.802678 ,  144.88887 ), weight:  1.28519561908337 },
    {location: new window.google.maps.LatLng( -37.805293 ,  144.88474 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.807725 ,  144.88432 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -37.810624 ,  144.883861 ), weight:  0.413789732096372 },
    {location: new window.google.maps.LatLng( -36.720888 ,  144.682762 ), weight:  0.332966978371909 },
    {location: new window.google.maps.LatLng( -36.720818 ,  144.682878 ), weight:  0.332966978371909 },
    {location: new window.google.maps.LatLng( -36.599102 ,  144.652965 ), weight:  0.0119526607620685 },
    {location: new window.google.maps.LatLng( -36.599105 ,  144.653055 ), weight:  0.0119526607620685 },
    {location: new window.google.maps.LatLng( -36.495308 ,  144.607892 ), weight:  0.0119526607620685 },
    {location: new window.google.maps.LatLng( -36.495348 ,  144.608118 ), weight:  0.0119526607620685 },
    {location: new window.google.maps.LatLng( -36.36227 ,  144.698717 ), weight:  0.0506565146582904 },
    {location: new window.google.maps.LatLng( -36.124085 ,  144.751928 ), weight:  0.745049187502271 },
    {location: new window.google.maps.LatLng( -35.956292 ,  144.368792 ), weight:  0.00398422025402284 },
    {location: new window.google.maps.LatLng( -35.95598 ,  144.3688 ), weight:  0.00398422025402284 },
    {location: new window.google.maps.LatLng( -36.028933 ,  144.51657 ), weight:  0.745049187502271 },
    {location: new window.google.maps.LatLng( -36.271742 ,  144.535782 ), weight:  0.0506565146582904 },
    {location: new window.google.maps.LatLng( -36.271677 ,  144.535817 ), weight:  0.0506565146582904 },
    {location: new window.google.maps.LatLng( -36.249943 ,  144.94828 ), weight:  0.0506565146582904 },
    {location: new window.google.maps.LatLng( -36.249807 ,  144.94808 ), weight:  0.0506565146582904 },
    {location: new window.google.maps.LatLng( -36.397072 ,  144.980858 ), weight:  0.240191563885377 },
    {location: new window.google.maps.LatLng( -36.445718 ,  144.982585 ), weight:  0.0142293580500816 },
    {location: new window.google.maps.LatLng( -36.445953 ,  144.982435 ), weight:  0.0142293580500816 }
  ]

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
  
        // import crimes from '../Data/crimesNormalised2.js';
        const crimes = require('../Data/crimesNormalised2.js')

  
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
          radius: 5, 
          maxIntensity: 1,
          gradient: gradientYarp
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