import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"

export const crimesUnweightedJson = {

  positions: [
    {"lat":-37.6896,"lng":145.1051,"weight":535},
    {"lat":-37.6867,"lng":145.1056,"weight":535},
    {"lat":-37.6836,"lng":145.1087,"weight":98},
    {"lat":-37.6826,"lng":145.1113,"weight":98},
    {"lat":-37.6853,"lng":145.1173,"weight":535},
    {"lat":-37.6828,"lng":145.1196,"weight":98},
    {"lat":-37.7364,"lng":145.0445,"weight":185},
    {"lat":-37.7224,"lng":145.0481,"weight":985},
    {"lat":-37.7416,"lng":145.0434,"weight":1093},
    {"lat":-37.7421,"lng":145.0482,"weight":1093},
    {"lat":-37.7465,"lng":145.0586,"weight":834},
    {"lat":-37.7445,"lng":145.062,"weight":834},
    {"lat":-37.7437,"lng":145.0634,"weight":834},
    {"lat":-37.7432,"lng":145.0666,"weight":834},
    {"lat":-37.7448,"lng":145.0675,"weight":834}]
};

// options: {
//   radius: 20,
//   opacity: 0.7,
// }


export default withGoogleMap(crimesUnweightedJson);