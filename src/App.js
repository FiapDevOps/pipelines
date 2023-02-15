import React, { Component } from 'react';
import logo from './logo.svg';
import mba from './MBA.png';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={mba} className="App-logo" alt="logo" />

          <h1 className="App-title">Welcome to FIAP 155GTI"</h1>

        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
          Made by: Gabriel, Marina and Victor
        </p>
      </div>
    );
  }
}

export default App;
