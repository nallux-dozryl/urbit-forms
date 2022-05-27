import { Component } from 'react';
import Urbit from '@urbit/http-api';
import HomePage from './components/HomePage';
import './App.css';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      state: null
    }
  }
  
  componentDidMount() {
    window.urbit = new Urbit("");
    window.urbit.ship = window.ship;
    window.urbit.onOpen = () => this.setState({status: "con"});
    window.urbit.onRetry = () => this.setState({status: "try"});
    window.urbit.onError = (err) => this.setState({status: "err"});
  }

  render() {
    return (
      <HomePage />
    )}
}
export default App;
