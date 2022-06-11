<script>
  //imports
  import Short from '../Pub/Questions/Short.svelte'

  // Main Area
  //import NewQuestion from './NewQuestion.svelte'

  // Defining things
  export let survey;

</script>

<div class="container">
  {#each survey[1] as q}
    {#if q.front === "short"}
      <Short q={q} sid={survey[0].id}/>
    {/if}
  {/each} 
</div>

<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
