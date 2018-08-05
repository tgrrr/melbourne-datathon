import React, { Component } from 'react';
import Home from '../../pages/Home/Home.js';
import axios from 'axios';

class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      dataObject: {},
      dataArray: []
    }
  }

  componentDidMount () {

    axios.get(`http://127.0.0.1:8888/demo`)
    .then(function(response) {
      console.log('data', response.data);
      console.log('status', response.status);
      console.log('statusText', response.statusText);
      console.log('headers', response.headers);
      console.log('config', response.config);
    });
  }

  render() {
    
    return (
      <div className="App">
        <Home />
      </div>
    );
  }
}

export default App;
