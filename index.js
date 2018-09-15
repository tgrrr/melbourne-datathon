import React from "react";
import PropTypes from "prop-types";
import ReactDOM from "react-dom";
import { AppContainer } from "react-hot-loader";
import Redbox from "redbox-react";
import App from './Components/App/App';
import Presentation from './Components/Presentation/Presentation.js';
const CustomErrorReporter = ({ error }) => <Redbox error={ error } />;

CustomErrorReporter.propTypes = {
  error: PropTypes.instanceOf(Error).isRequired
};

ReactDOM.render(
  <AppContainer errorReporter={CustomErrorReporter}>
    <App />
  </AppContainer>,
  document.getElementById("root"),
);

if (module.hot) {
  module.hot.accept("./Components/App/App", () => {
    const NextApp = require("./Components/App/App").default;

    ReactDOM.render(
      <AppContainer errorReporter={CustomErrorReporter}>
        <NextApp />
      </AppContainer>,
      document.getElementById("root"),
    );
  });
}
