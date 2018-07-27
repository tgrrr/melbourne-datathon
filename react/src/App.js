import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  // { data } = this.state;

  componentDidMount () {
    // header("Access-Control-Allow-Methods: GET, POST, HEAD, OPTIONS, PUT, DELETE, PATCH");
    const options = {
      method: 'get',
      
      headers: {
          "Access-Control-Request-Headers": "*",
          "Access-Control-Request-Method": "*"
      },
    }
    fetch(
      `http://127.0.0.1:8888/text`, options)
      .then(result=>console.log(result))
      // .then(result => { return result.json()})
      // .then(data=> {
      //   this.setState({
      //     data:data.response
      //   });
      // })
      // .then(console.log('data', this.state.data))
  }
  render() {

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;
