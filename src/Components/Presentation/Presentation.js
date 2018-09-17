// Import React
import React from "react";
// Import Spectacle Core tags
import {
  BlockQuote,
  Cite,
  Deck,
  Heading,
  ListItem,
  List,
  Quote,
  Slide,
  Text
} from "spectacle";
import HeatMap from '../Maps/Maps';
import MyMapComponent from '../Maps/Maps-library2';
// Import theme
import createTheme from "spectacle/lib/themes/default";
// import { crimesWeightedJson } from '../Data/crimes_weighted_json';
// import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON.js';
import { crimesUnweightedJson } from '../Data/crimes_unweightedJSON.js';
import MapPoints from '../MapPoints/MapPoints';
// import foo from '../Data/crime_tram_model_Normalised--nocbd.json';
import axios from 'axios';

// import MapCoordinates from '../MapPoints/MapPoints.js';

// Require CSS
require("normalize.css");

const theme = createTheme({
  primary: "white",
  secondary: "#1F2022",
  tertiary: "#03A9FC",
  quaternary: "#CECECE"
}, {
  primary: "Montserrat",
  secondary: "Helvetica"
});

export default class Presentation extends React.Component {
  render() {
    return (
      <Deck transition={["zoom", "slide"]} transitionDuration={500} theme={theme}>
        <Slide transition={["zoom"]} bgColor="primary">
          <Heading size={1} fit caps lineHeight={1} textColor="secondary">
            Saved by the Bell
          </Heading>
          <Text margin="10px 0 0" textColor="tertiary" size={1} fit bold>
            Increasing personal safety on PT
          </Text>
        </Slide>
        {/* <Slide transition={["zoom"]} bgColor="primary">
          <Text margin="10px 0 0" textColor="tertiary" size={1} fit bold>
            <MapPoints 
              mapPoints={crimesUnweightedJson} 
            />
          </Text>
        </Slide> */}
        <Slide bgColor="secondary">
          <MyMapComponent heatmapData = {crimesUnweightedJson} />
        </Slide>
        <Slide bgColor="primary">
          <HeatMap heatmapData = {crimesUnweightedJson} />
        </Slide>
        {/* <Slide transition={["zoom"]} bgColor="primary">
          <MapCoordinates mapPoints={this.state.rlangApi ? this.state.rlangApi : null} />
        </Slide>         */}
        <Slide transition={["fade"]} bgColor="tertiary">
          <Heading size={6} textColor="primary" caps>Typography</Heading>
          <Heading size={1} textColor="secondary">Heading 1</Heading>
          <Heading size={2} textColor="secondary">Heading 2</Heading>
          <Heading size={3} textColor="secondary">Heading 3</Heading>
          <Heading size={4} textColor="secondary">Heading 4</Heading>
          <Heading size={5} textColor="secondary">Heading 5</Heading>
          <Text size={6} textColor="secondary">Standard text</Text>
        </Slide>
        <Slide transition={["fade"]} bgColor="primary" textColor="tertiary">
          <Heading size={6} textColor="secondary" caps>Standard List</Heading>
          <List>
            <ListItem>Item 1</ListItem>
            <ListItem>Item 2</ListItem>
            <ListItem>Item 3</ListItem>
            <ListItem>Item 4</ListItem>
          </List>
        </Slide>
        <Slide transition={["fade"]} bgColor="secondary" textColor="primary">
          <BlockQuote>
            <Quote>Example Quote</Quote>
            <Cite>Author</Cite>
          </BlockQuote>
        </Slide>
      </Deck>
    );
  }
}
