<script>
  import { requestSurvey } from '../UrbitStore'
	import { createEventDispatcher } from 'svelte';

  let addr;

  const dispatch = createEventDispatcher()

  function askSurvey(ship, data) {
    requestSurvey(ship, data)
    setTimeout(() => { dispatch('update', ship) }, 1000);
  }

</script>

<div class="ask-form">
  <input 
    type="text" 
    placeholder="~zod/example-form" 
    bind:value={addr} 
  />
  <button 
    on:click={askSurvey(window.ship, addr)}
    class="request"
  >
    Request
  </button>
</div>

<style>

  input {
    flex: 8;
    border: 2px solid black;
    padding: .618em;
  }
  
  .ask-form {
    display: flex;
    margin: 0 2px .618em 2px;
  }

  .request {
    flex: 2;
    background: white;
    margin-left: .618em;
    border: 2px solid black;
  }

  .request:hover {
    background: black;
    color: white;
  }


</style>
