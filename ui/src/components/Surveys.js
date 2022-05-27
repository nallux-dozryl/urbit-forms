import { Component } from 'react';
import { Dropdown, ButtonGroup, Button } from 'react-bootstrap';

class Surveys extends Component {
  constructor(props) {
    super(props);

    this.state = {
      msg: "def",
      surveys: {}
    }

    this.getSurveys = this.getSurveys.bind(this)

  }

  componentDidMount() {    
    this.getSurveys()    
      .then(    
        (result) => { console.log("result" + result) },
        (err) => { console.log("err: " + err) }    
      )    
  }  

  getSurveys = async () =>  {
    return window.urbit.scry({
      app: "forms",
      path: "/surveys/live"
    })
  }

  getSur = async () =>  {
    const path = "/sur";
    return window.urbit.scry({
      app: "forms",
      path: path
    })
  }


  render() {
    return(
      <>
      {JSON.stringify(this.state.surveys)}
      <Dropdown as={ButtonGroup}>
        <Button
          variant="outline-dark" 
          className="survey-button">
          Example Form 1
        </Button>
        <Dropdown.Toggle 
          split 
          variant="outline-dark" 
        />
        <Dropdown.Menu>
          <Dropdown.Item>Edit</Dropdown.Item>
          <Dropdown.Item>Delete</Dropdown.Item>
          <Dropdown.Item>Clone</Dropdown.Item>
        </Dropdown.Menu>
      </Dropdown> 
      </>

    )


  }


}
export default Surveys
