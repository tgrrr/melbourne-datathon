import React, { Component } from 'react';
import Home from '../pages/Home/Home';
import Plotly from '../Plotly/Plotly';
import HeatMap from '../Maps/Maps';
import Presentation from '../presentation/presentation';
import { crimesWeightedJson } from '../../data/crimes_weighted_json';
import MapCoordinates from '../MapPoints/MapPoints.js';

import axios from 'axios';

class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      rlangApi: [],
      loading: true,
    }
  }

  componentDidMount () {

    const delta = (response) => (
      this.setState({rlangApi: response.data.output})
    )

    axios.get(`http://127.0.0.1:8888/demo`)
    .then(function(response) {
      response && delta(response)
      this.setState({loading: false})
    })
    .catch((e) =>
    {
      console.error(e);
    })
    
    
  }

  render() {
    return (
      <div className="App">

        <Presentation />

        {/* rendering heatmap without presentation */}
        {/* <HeatMap heatmapData = {crimesWeightedJson} /> */}
        {/* {(this.state.loading = false)
          ? <HeatMap 
            // heatmapData = {this.state.rlangApi}
              heatmapData = {crimesWeightedJson}
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
