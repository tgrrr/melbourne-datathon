import React, { Component } from 'react';
import logo from './assets/zac__shoulders.jpg';
import './App.css';

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
      // .then(result => { console.log(result.json())})
      .then(function(data) {
        console.log('data', data);  // { "userId": 1, "id": 1, "title": "...", "body": "..." }
      })
      .then(data => {

        // array and objects to state
        // const dataArray = Object.keys(data).map(function(key) {
        //   return [Number(key), data[key]];
        // });
  
        // this.setState({dataObject: {object: data}});
        // this.setState({
        //   dataArray: dataArray
        // });
      })
      .then(console.log('this.state', this.state))
  }

  render() {
    
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Saved by the Bell Curve</h1>
        </header>
        <p className="App-intro">
          Screech is awesome
          
          {/* {this.state.data ? this.state.data.output : null} */}
        </p>
      </div>
    );
  }
}

export default App;
