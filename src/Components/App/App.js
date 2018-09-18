import React, { Component } from 'react';
// import axios from 'axios';

import Presentation from '../Presentation/Presentation';

import ParticleEffectButton from 'react-particle-effect-button'
import DemoBlock from '../Button/Button.js';
import _ButtonConfig from '../Button/_ButtonConfig.js'


class App extends Component {

    state = {
      loading: true,
      hidden: false,
      loading: false,
    }

  _onToggle = () => {
    console.log('ontoggle');
    // if (this.state.animating) return

    this.setState({
      hidden: !this.state.hidden,
      animating: true
    })
  }

  _onAnimationComplete = () => {
    this.setState({
      animating: false
    })
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
    console.log('state', this.state);
    return (
      <div className="App">
        <Presentation />
      </div>
    );
  }
}

export default App;
