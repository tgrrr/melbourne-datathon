import React, { Component } from 'react';
import PropTypes from 'prop-types';

import ParticleEffectButton from 'react-particle-effect-button'
import DemoBlock from '../Button/Button.js';
import _ButtonConfig from '../Button/_ButtonConfig.js'

import {
  Appear,
  BlockQuote,
  Cite,
  Deck,
  Heading,
  Image,
  ListItem,
  List,
  Quote,
  Slide,
  Text,
  GoToAction,
} from "spectacle";

import Maps from '../Maps/Maps';

import createTheme from "spectacle/lib/themes/default";

import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON.js';

require("normalize.css");

const images = {
  city: require('../../assets/city.jpg'),
  kat: require('../../assets/safety_bubbles.png'),
};

const theme = createTheme({
  primary: 'white',
  secondary: '#B45439',
  tertiary: '#03A9FC',
  quaternary: '#586668'
}, {

  primary: 'Roboto',  
  secondary: 'Montserrat',
  tertiary: 'Helvetica',
  
});

export default class Presentation extends Component {

  state = {
    hidden: false,
    animating: false
  }

  _onToggle = () => {
    console.log('ontoggle');
    if (this.state.animating) return

    this.setState({
      hidden: !this.state.hidden,
      animating: true
    })
  }

  _onAnimationComplete = (target) => {
    console.log('_onAnimationComplete');

    this.setState({
      animating: false
    });
    // goToSlide(1);
  }

  render () {
    
    const {
      hidden,
      animating
    } = this.state
      
    return(
      <Deck theme={theme}>
        <Slide bgColor="quaternary">
          <Maps heatmapData = {crimesUnweightedJson} />
        </Slide>
        <Slide transition={["zoom"]} bgColor="quaternary">
          <Heading size={6} textColor="primary" fit>Safety by numbers</Heading>
            <GoToAction margin="1em" slide={2}>
                Get started...
            </GoToAction>
          <Heading size={6} textColor="primary">Safety by numbers
          Hit your right arrow to begin<br />
          (or swipe right...)</Heading>
        </Slide>
        <Slide transition={["zoom"]} bgColor="quaternary">
          <Heading size={6} textColor="primary">An app to help</Heading>
          <Heading size={4} textColor="secondary">Melbourne locals</Heading>
          <Heading size={5} textColor="primary">Find the safest way home</Heading>
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>We've mapped</Heading>
          <List>
            <Appear>
              <ListItem>Where most users travel late at night</ListItem>
            </Appear>
            <Appear>
              <p>(to find safety in numbers)</p>
            </Appear>
            <Appear>
              <ListItem>Crime hotspots</ListItem>
            </Appear>
            <Appear>
              <ListItem>Vunerable users by concession card</ListItem>
            </Appear>
            <Appear>
              <ListItem>Tram stops that cars speed past</ListItem>
            </Appear>
          </List>
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>Users can find</Heading>
          <List>
            <Appear>
              <ListItem>Where they get off the most</ListItem>
            </Appear>
            <Appear>
              <ListItem>Safe places near them </ListItem>
            </Appear>
            <Appear>
              <h6><center>like police stations, open pubs, and supermarkets</center></h6>
            </Appear>
            <Appear>
              <ListItem>Tram stops that cars speed past</ListItem>
            </Appear>
            <Appear>
              <ListItem>Where users travel late at night</ListItem>
            </Appear>
          </List>
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>PTV can see</Heading>
          <List>
            <Appear>
              <ListItem>The best spots to add public service officers</ListItem>
            </Appear>
            <Appear>
              <ListItem>Where to improve pedestrian crossings at tram stops</ListItem>
            </Appear>
            <Appear>
              <ListItem>How an individual uses the system</ListItem>
            </Appear>
            <Appear>
              <ListItem>Should tram stops have public service officers?</ListItem>
            </Appear>
          </List>
        </Slide>
        <Slide transition={["zoom"]} bgColor="quaternary">
          <Heading size={5} textColor="primary">Without Further Ado</Heading>
          <Heading size={4} textColor="secondary">Lets use the app</Heading>
          {/* <Heading size={2} textColor="secondary">Heading 2</Heading> */}
            <GoToAction margin="1em" slide={7}>
                Improve your safety
            </GoToAction>
          <Text>Hit your right arrow to improve your safety</Text>
        </Slide>
        <Slide transition={["zoom"]} bgColor="quaternary">
          <Text>What's your myki card number?</Text>

          <input name="myki name" />
            <GoToAction margin="1em" slide={8}>
                Improve your safety
            </GoToAction>
            <Text>Hint, this is just a demo, anything will do</Text>
        </Slide>
        <Slide transition={["zoom"]} bgColor="primary">
          <Text>Hey! 14% of your trips are high risk!</Text>
          <GoToAction margin="1em" slide={9}>
              Tell me more, tell me more...
          </GoToAction>
        </Slide>
        <Slide transition={["zoom"]} bgColor="primary">
          <Image src={images.kat.replace('/', '')} margin="0px auto 40px" />
        </Slide>


        <Slide transition={["zoom"]} bgColor="secondary">
          <Heading size={6} textColor="primary">We're sorry that it can be unsafe out there</Heading>
          <Heading size={4} textColor="tertiary">And it's definitely not your fault</Heading>
        </Slide>

        <Slide transition={["zoom"]} bgColor="secondary">
          <Appear>
          <Heading size={6} textColor="primary">
            We do have some personalised suggestions if you'd like to improve your safety</Heading>
          </Appear>
          <Appear>
            <Heading size={6} textColor="tertiary">and we understand if you'd rather do your own thing</Heading>
          </Appear>
          <Appear>
            <div>
              <Text>Would you like to get some personalised tips...</Text>
              <GoToAction margin="1em" slide={9}>
                Thanks...
              </GoToAction>
              <GoToAction margin="1em" slide={10}>
                But no thanks...
              </GoToAction>
            </div>
          </Appear>
        </Slide>

        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>You might be able to improve your safety by...</Heading>
          <List>
            <Appear>
              <ListItem>Try tram 19 rather than 57 after dark, because it has twice the number of passengers</ListItem>
            </Appear>
            <Appear>
              <ListItem>There is better lit parking at Moreland Station than Coburg</ListItem>
            </Appear>
            <Appear>
              <ListItem>There are PSO's at at Coburg and Moreland Station until the last train</ListItem>
            </Appear>
            <Appear>
              <ListItem>Where to improve pedestrian crossings at tram stops</ListItem>
            </Appear>
          </List>
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>Here's some general safety tips...</Heading>
          <List>
            <Appear>
              <ListItem>Tip # 1 intentionally left blank</ListItem>
            </Appear>
            <Appear>
              <ListItem>Tip # 2 intentionally left blank</ListItem>
            </Appear>
            <Appear>
              <ListItem>Tip # 3 intentionally left blank</ListItem>
            </Appear>
            <Appear>
              <ListItem>Tip # 4 intentionally left blank</ListItem>
            </Appear>
          </List>
        </Slide>


        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>Here's the average crime by tram stop map</Heading>
          <Maps />
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="primary">
            And finally, lets check your travel history, and find some safe places near where you frequent
          </Heading>
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="secondary" caps>Here's the average crime by tram stop map</Heading>
          <Maps />
        </Slide>
        <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <Heading size={6} textColor="primary">
            Thanks!
          </Heading>
          <Heading size={6} textColor="secondary">
            Saved by the Bell Curve team
          </Heading>

        </Slide>



        {/* <Slide transition={["fade"]} bgColor="quaternary" textColor="primary">
          <BlockQuote>
            <Quote>Example Quote</Quote>
            <Cite>Author</Cite>
          </BlockQuote>
        </Slide> */}
      </Deck>
    );
}};