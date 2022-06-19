<script>
  import { createSurvey } from '../UrbitStore'

  let data = {
    title: "",
    description: "",
    visibility: "private",
    slug: "",
    rlimit: 0
  };

</script>

<div class="create-container">
      <p>Title</p>
      <input 
        type="text"
        placeholder="Example title"
        bind:value={data.title}
      />
      <p>Description</p>
      <input 
        type="text"
        placeholder="Additional information.."
        bind:value={data.description}
      />
      <p>Visibility</p>
      <select bind:value={data.visibility}>
        <option value="public">Public</option>
        <option value="private">Private</option>
      </select>
      <p>Custom Link</p>
      <input 
        type="text"
        placeholder="only-dashes-allowed"
        bind:value={data.slug}
      />
      <div class="submit-buttons">
        <button
          class="cancel"
        >
          Cancel
        </button>
        <button 
          on:click={createSurvey(window.ship, data)}
          class="submit"
        >
          Create!
        </button>
      </div>
</div>

<style>
  
  .create-container {
    display: flex;
    flex-direction: column;
    padding: .618em .618em 2.382em .618em;
  }

  .submit-buttons {
    display: flex;
    flex: 1;
  }

  .cancel {
    flex: 1;
    background: white;
    border: 2px solid #ff2c2c;
    padding: 0.618em 0 0.618em 0;
    color: #ff2c2c;
    margin: 0.618em;
  }

  .cancel:hover {
    background: #ff2c2c;
    color: white;
  }

  .submit {
    flex: 1;
    background: white;
    border: 2px solid black;
    padding: 0.618em 0 0.618em 0;
    color: black;
    margin: .618em;
  }

  .submit:hover {
    background: black;
    color: white;
  }

  p {
    flex: 1;
    margin: 0 0 4px 0;
    justify-content: center;
  }

  input {
    flex: 1;
    border: 2px solid black;
    background: white;
    margin-bottom: 0.618em;
    padding: .618em;
  }

  select {
    flex: 1;
    border: 2px solid black;
    border-radius: none;
    background: white;
    margin-bottom: 0.618em;
    padding: .618em;
  }

</style>
