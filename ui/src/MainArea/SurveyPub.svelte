<script>
  //imports
  import { submitResponse } from '../UrbitStore' 
  import QContainer from '../Pub/QContainer.svelte'

  function handleSubmit() {
    submitResponse({surveyid: survey[0].id})
  }
  // Defining things
  export let survey;

</script>

<div class="container">
  {#each survey[1] as q}
    <QContainer qs={q}/>
  {/each} 
  <button on:click={handleSubmit}>Submit</button>
</div>

<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
