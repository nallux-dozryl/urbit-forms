<script>
  //imports
  import { responses, submitResponse } from '../UrbitStore' 
  import QContainer from '../Resp/QContainer.svelte'

  function handleSubmit() {
    submitResponse({surveyid: survey[0].id})
  }
  // Defining things
  export let survey;

  let resp;
  let count = 0;

  function sub() {
      if (count > 0) {
      count = count - 1    
    }
  }

  function add() {
      if (count < (resp.length - 1)) {
      count = count + 1    
    }
  }

  responses.subscribe(res => resp = res)
</script>
<span>Submitted by ~{resp[count].author}</span>
{#if resp.length > 0}
  <div class="container">
    {#each survey[1] as q}
      <QContainer qs={q} ans={resp[count]}/>
    {/each}
  </div>
  <div class="inc">
    <button on:click={sub}> prev </button>
      {count + 1} / {resp.length}
    <button on:click={add}> next </button>
  </div>
{:else}
  <span>No responses yet!</span>
{/if}
<style>

  .container {
    width: 80%;
    margin: auto;
  }

  .inc {
    text-align: center;
    margin: 1em;
  }

</style>
