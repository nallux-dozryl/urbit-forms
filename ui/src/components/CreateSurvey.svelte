<script>
  import { createSurvey } from '../UrbitStore'
	import { createEventDispatcher } from 'svelte';

  const dispatch = createEventDispatcher()

  let isCreate = false;
  let data = {
    title: "",
    description: "",
    visibility: "public",
    slug: "",
    rlimit: 0
  };

  function newSurvey(ship, data) {
    createSurvey(ship, data)
    dispatch('update', ship)
  }

</script>

<div class="create-container">
  {#if isCreate}
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
      <p>Max Submissions per Person (0 for unlimited)</p>
      <input 
        min=0
        type="number"
        bind:value={data.rlimit}
      />

      <div class="submit-buttons">
        <button
          on:click={()=> isCreate = !isCreate}
          class="cancel"
        >
          Cancel
        </button>
        <button 
          on:click={newSurvey(window.ship, data)}
          class="submit"
        >
          Create!
        </button>
      </div>
  {:else}
    <button 
      on:click={()=> isCreate = !isCreate } 
      class="create-button"
    >
      + Create
    </button>
  {/if}
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

  .create-button {
    flex: 1;
    background: white;
    border: 2px solid black;
    padding: 0.618em 0 0.618em 0;
  }

  .create-button:hover {
    background: black;  
    color: white;
  }

  .info {
    display: flex;
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
