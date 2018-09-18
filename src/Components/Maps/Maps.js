import React from 'react';
import _ from 'lodash';
// import propTypes from 'prop-types';
import { compose, withProps, lifecycle } from 'recompose';
// import _MapPoints from './_MapPoints.js';

// React Google Maps
import { 
  FusionTablesLayer,
  GoogleMap, 
  // Marker, 
  withGoogleMap, 
  withScriptjs, 
} from 'react-google-maps';
// import HeatmapLayer from "react-google-maps/lib/components/visualization/HeatmapLayer";
// import { MarkerClusterer }  from 'react-google-maps/lib/components/addons/MarkerClusterer';
import { SearchBox } from 'react-google-maps/lib/components/places/SearchBox';

// data
// import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON';
// import { users } from '../Data/user_shortdata';

// styles
import _lightMapStyle from './_lightMapStyle';
// import _gradientColor from './_gradientColor';


const googleMapURL = 
  'https://maps.googleapis.com/maps/api/js?key=' +
  process.env.REACT_APP_GOOGLE_MAPS +
  '&v=3.exp&libraries=' +
  'geometry,drawing,places,visualization';

const Maps = 
  compose(
    withProps({
      googleMapURL: googleMapURL,
      containerElement: <div style={{ height: `600px` }} />,
      loadingElement: <div style={{ height: `100%` }} />,
      mapElement: <div style={{ height: `100%` }} />,
    }),
    lifecycle({
      componentWillMount() {
        const refs = {}
    
        this.setState({
          bounds: null,
          center: {
            lat: 41.9, lng: -87.624
          },
          markers: [],
          onMapMounted: ref => {
            refs.map = ref;
          },
          onBoundsChanged: () => {
            this.setState({
              bounds: refs.map.getBounds(),
              center: refs.map.getCenter(),
            })
          },
          onSearchBoxMounted: ref => {
            refs.searchBox = ref;
          },
          onPlacesChanged: () => {
            const places = refs.searchBox.getPlaces();
            const bounds = new window.google.maps.LatLngBounds();
    
            places.forEach(place => {
              if (place.geometry.viewport) {
                bounds.union(place.geometry.viewport)
              } else {
                bounds.extend(place.geometry.location)
              }
            });
            const nextMarkers = places.map(place => ({
              position: place.geometry.location,
            }));
            const nextCenter = _.get(nextMarkers, '0.position', this.state.center);
    
            this.setState({
              center: nextCenter,
              markers: nextMarkers,
            });
            // refs.map.fitBounds(bounds);
          },
        })
      },
    }),
    withScriptjs,
    withGoogleMap
  )(props => {
  
  // const crimes = require('../Data/crimes5000normalised.js')  

  return (
    <GoogleMap
      defaultZoom = {8}
      defaultCenter = {{ lat: -37.8232433, lng: 144.950098 }}
      defaultOptions={{ styles: _lightMapStyle }}
    >

      <SearchBox
        ref={props.onSearchBoxMounted}
        bounds={props.bounds}
        controlPosition={window.google.maps.ControlPosition.TOP_LEFT}
        onPlacesChanged={props.onPlacesChanged}
      >
        <input
          type="text"
          placeholder="search for somewhere safe"
          style={{
            boxSizing: `border-box`,
            border: `1px solid transparent`,
            width: `240px`,
            height: `32px`,
            marginTop: `27px`,
            padding: `0 12px`,
            borderRadius: `3px`,
            boxShadow: `0 2px 6px rgba(0, 0, 0, 0.3)`,
            fontSize: `14px`,
            outline: `none`,
            textOverflow: `ellipses`,
          }}
        />
      </SearchBox>
      
    {/* {users.map((user, id) =>
      <_MapPoints
        key = {id} 
        position={{      
          lat: user.lat,
          lng: user.lng, 
        }} 
      />)
    } */}

      <FusionTablesLayer
        url="http://googlemaps.github.io/js-v2-samples/ggeoxml/cta.kml"
        options={{
          query: {
            select: `Geocodable address`,
            from: `1MDGMHi3VGWc43lXHednXdpyGlrOuzvOdmeDHWbRb`
          },
          heatmap: {
            enabled: true
          }
        }}
      />
    </GoogleMap>
  );
});

export default Maps;