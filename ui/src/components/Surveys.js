import { Nav, Dropdown, ButtonGroup, Button } from 'react-bootstrap';
import { useState } from 'react';

export default function Surveys(props) {

  const [tab, setTab] = useState("all")

  const listSurveys = props.surveys.map(survey =>
    <Dropdown as={ButtonGroup}>
      <Button
        key={survey.id}
        variant="outline-dark" 
        className="survey-button">
        {survey.title}
      </Button>
      <Dropdown.Toggle 
        split 
        variant="outline-dark" 
      />
      <Dropdown.Menu>
        { survey.author === window.ship 
          ? <Dropdown.Item>Edit</Dropdown.Item>
          : null
        }
        <Dropdown.Item>Delete</Dropdown.Item>
        <Dropdown.Item>Clone</Dropdown.Item>
      </Dropdown.Menu>
    </Dropdown> 
    )

  const listMySurveys = props.surveys.map(survey =>
    <>
    {survey.author === window.ship ?
    <Dropdown as={ButtonGroup}>
      <Button
        key={survey.id}
        variant="outline-dark" 
        className="survey-button">
        {survey.title}
      </Button>
      <Dropdown.Toggle 
        split 
        variant="outline-dark" 
      />
      <Dropdown.Menu>
        { survey.author === window.ship 
          ? <Dropdown.Item>Edit</Dropdown.Item>
          : null
        }
        <Dropdown.Item>Delete</Dropdown.Item>
        <Dropdown.Item>Clone</Dropdown.Item>
      </Dropdown.Menu>
    </Dropdown> 
    : null } 
    </> )

  return (
    <>
      <Nav 
        variant="tabs" 
        defaultActiveKey="all"
        className="justify-content-center"
        onSelect={(e) => setTab(e)}
      >
        <Nav.Item>
          <Nav.Link eventKey="all">
            All
          </Nav.Link>
        </Nav.Item>
        <Nav.Item>
          <Nav.Link 
            eventKey="owned"
          >
            Owned
          </Nav.Link>
        </Nav.Item>
        <Nav.Item>
          <Nav.Link eventKey="defunct" disabled>
            Defunct
          </Nav.Link>
        </Nav.Item>
      </Nav>
        {tab === "owned" ? listMySurveys : tab === "all" ? listSurveys : null}
      </>
  )
}
