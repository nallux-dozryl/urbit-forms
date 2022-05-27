import { Component } from 'react';
import { Modal, Button, Form } from 'react-bootstrap';

class CreateModal extends Component {
  constructor(props) {
    super(props);

    this.state = {
      msg: "def",
      toggleCreate: false,
      title: "",
      description: "",
      visibility: "public",
      slug: "",
      rlimit: ""
    }

    this.handleCreate = this.handleCreate.bind(this)
    this.handleChange = this.handleChange.bind(this)
    this.submitNew = this.submitNew.bind(this)

  }

  handleCreate() {
    this.setState(prevState => ({
      toggleCreate: !prevState.toggleCreate
    }))
  }

  handleChange(e) { 
    this.setState({[e.target.name]: e.target.value})
  }

  submitNew() {
    window.urbit.poke({
      app: "forms",
      mark: "forms-action",
      json: {
        "create":{
          title: this.state.title,
          description: this.state.description,
          visibility: this.state.visibility,
          slug: this.state.slug,
          rlimit: parseInt(this.state.rlimit)
        }
      },
      onSuccess: ()=>this.setState({
        msg: "success",
        title: "",
        description: "",
        visibility: "public",
        slug: "",
        rlimit: ""
      }),
      onError: ()=>this.setState({msg: "failed"})})
  }

  render() {
    return(
    <>
      <Button 
         className="create-button"
         variant="outline-dark"
         onClick={this.handleCreate}
      >
        +
      </Button>
      <Modal show={this.state.toggleCreate} onHide={this.handleCreate}>
        <Modal.Header closeButton>
          <Modal.Title>New Form {this.state.msg}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group>
              <Form.Label>Title</Form.Label>
              <Form.Control
                name="title"
                placeholder="Example Form Title" 
                value={this.state.title}
                onChange={this.handleChange}
              />
            </Form.Group>
            <Form.Group>
              <Form.Label>Description</Form.Label>
              <Form.Control
                name="description"
                placeholder="form description" 
                value={this.state.description}
                onChange={this.handleChange}
              />
            </Form.Group>
            <Form.Group>
              <Form.Label>Visibility</Form.Label>
              <Form.Select
                name="visibility"
                value={this.state.visibility}
                onChange={this.handleChange}>
                <option value="public">Public</option>
                <option value="private">Private</option>
              </Form.Select>
            </Form.Group>
            <Form.Group>
              <Form.Label>Slug</Form.Label>
              <Form.Control
                name="slug"
                placeholder="custom-form-link (dashes only!)" 
                value={this.state.slug}
                onChange={this.handleChange}
              />
            </Form.Group>
            <Form.Group>
              <Form.Label>Response Limit</Form.Label>
              <Form.Control
                name="rlimit"
                placeholder="integers only!"
                value={this.state.rlimit}
                onChange={this.handleChange}
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button 
            variant="outline-dark"
            onClick={this.submitNew} 
          >Create</Button>
        </Modal.Footer>
      </Modal>
    </>
    )
 }




}
export default CreateModal
