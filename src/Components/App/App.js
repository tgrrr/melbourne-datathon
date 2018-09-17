import React, { Component } from 'react';
import Presentation from '../Presentation/Presentation';
import HeatMap from '../Maps/Maps';
import crimes from '../Data/crime_tram_model_Normalised--nocbd.js';
// import { crimesWeightedJson } from '../Data/crimes_weighted_json';
// import { crimesUnweighted } from '../Data/crimes_unweightedJSON';
// import MapCoordinates from '../MapPoints/MapPoints';

import crimejson from '../Data/crime_tram_model_Normalised--nocbd.json';
import axios from 'axios';

import MyMapComponent from '../Maps/Maps-library2.js';

// const url = 'https://s3-ap-southeast-2.amazonaws.com/melbourne-datathon-saved-by-the-bell/crime_tram_model_Normalised--nocbd.json'

class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      rlangApi: [],
      loading: true,
    }
  }

  componentDidMount () {

    // const delta = (response) => (
    //   this.setState({rlangApi: response.data.output})
    // )
    // 
    // axios.get(`http://127.0.0.1:8888/demo`)
    // .then(function(response) {
    //   response && delta(response)
    //   this.setState({loading: false})
    // })
    // .catch((e) =>
    // {
    //   console.error(e);
    // })
      
  }

  render() {
    
    return (
      <div className="App">
        {/* <Presentation /> */}
        {/* <HeatMap heatmapData = {crimes} /> */}

        <MyMapComponent />

        {/* rendering heatmap without presentation */}
        {/* <HeatMap heatmapData = {crimesWeightedJson} /> */}
        {/* {(this.state.loading = false)
          ? <HeatMap 
            // heatmapData = {this.state.rlangApi}
              heatmapData = {crimes}
            />
          : <div />
        } */}

        {/* {JSON.stringify(this.state.rlangApi[0])} */}
        {/* {this.state.rlangApi} */}
      </div>
    );
  }
}

export default App;
