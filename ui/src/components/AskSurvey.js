import { Component } from 'react';
import { Stack, Button, Form } from 'react-bootstrap';
import CreateModal from './CreateModal';

class AskSurvey extends Component {
  constructor(props) {
    super(props);
    this.state = {
      msg: "def",
      addr: ""
    }
    this.handleChange = this.handleChange.bind(this)
    this.askSurvey = this.askSurvey.bind(this)

  }

  askSurvey() {

    const arr = this.state.addr.split("/")

    window.urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {
        "ask":{
          author: arr[0],
          slug: arr[2]
        }
      },
      onSuccess: ()=>this.setState({
        msg: "success",
        addr: ""
      }),
      onError: ()=>this.setState({msg: "failed"})})
  }

  handleChange(e) { 

    this.setState({[e.target.name]: e.target.value})


  }
  
  render() {
    return(
      <Stack direction="horizontal" gap={3}>
        <Form.Control 
          name="addr"
          value={this.state.addr}
          onChange={this.handleChange}
          className="me-auto" 
          placeholder="~zod/forms/example-form"/>
          <Button 
            variant="outline-dark"
            onClick={this.askSurvey}>Request</Button>
          <CreateModal />

      </Stack>
    )
  }
}
export default AskSurvey
