import React, { Component } from 'react';
import Home from '../Home/Home.js';

class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      dataObject: {},
      dataArray: []
    }
  }

  componentDidMount () {

    // header("Access-Control-Allow-Methods: GET, POST, HEAD, OPTIONS, PUT, DELETE, PATCH");
    const options = {
      method: 'get',
      headers: {
          "Access-Control-Request-Headers": "*",
          "Access-Control-Request-Method": "*"
      },
    }
    // TODO: CORS error coming from R
    fetch(`http://127.0.0.1:8888/bar`, options)
      .then(function(response) {
        return response;
        // return response.json();
      })
      .then(result => { result.json()})
      .then(function(data) {
        console.log('data', data);
      })
      // .then(data => {
    
      //  // array and objects to state
      //   const dataArray = Object.keys(data).map(function(key) {
      //     return [Number(key), data[key]];
      //   });
      //
      //   this.setState({dataObject: {object: data}});
      //   this.setState({
      //     dataArray: dataArray
      //   });
      // })
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
