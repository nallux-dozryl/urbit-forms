import { Component } from 'react';
import { Container, Row, Col, Stack } from 'react-bootstrap';
import CreateModal from './CreateModal';
import AskSurvey from './AskSurvey';
import Surveys from './Surveys';

class HomePage extends Component {

  render() {
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
              <CreateModal />
              <Surveys />
            </Stack>
          </Col>
        </Row>
      </Container>
    )

  }
}






export default HomePage 
