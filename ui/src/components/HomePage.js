import { useState, useEffect } from 'react';
import Urbit from '@urbit/http-api';
import { Container, Row, Col, Stack } from 'react-bootstrap';
import AskSurvey from './AskSurvey';
import Surveys from './Surveys';

export default function HomePage() {
 
  const [surveys, setSurveys] = useState([])

  useEffect(() => {
    window.urbit = new Urbit("");
    window.urbit.ship = window.ship;
//    window.urbit.onOpen = () => this.setState({status: "con"});
//    window.urbit.onRetry = () => this.setState({status: "try"});
//    window.urbit.onError = (err) => this.setState({status: "err"});

    const getSurveys = async () =>  {
      return window.urbit.scry({
        app: "forms",
        path: "/surveys/live"
      })
    }

  getSurveys().then(
        (result) => { setSurveys(result) },
        (err) => { console.log("err: " + err) }    
      )    
  })

    return(
      <Container fluid className="App">
        <Row>
          <Col 
            xxl={{ span: 4, offset: 4 }}
            xl={{ span: 6, offset: 3 }}
            lg={{ span: 8, offset: 2 }} 
            md={{ span: 10, offset: 1 }}
          >
            <Stack gap={2}>
              <AskSurvey />
              <Surveys surveys={surveys} />
            </Stack>
          </Col>
        </Row>
      </Container>
    )

  }
